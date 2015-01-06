class MembersController < ApplicationController
  def create
  	member = Member.new(member_params)
  	if member.save
  	  sign_in member
  	  flash[:success] = "恭喜您注册成功！"
      redirect_to members_path
  	else
      flash[:danger] = "注册失败，再来一次。"
      redirect_to :back
  	end
  end

  def index
    @member = Member.find(current_user.id)
    # chart图初始月份
    @next_month = (Time.new + 1.month).strftime('%Y-%m-%d')[0,7]
    @previous_month = (Time.new - 1.month).strftime('%Y-%m-%d')[0,7]
    # 血压图
    blood_pressure_chart(@member.id,"","")
    # 血糖值
    blood_sugar_chart(@member.id,"","")
    # 尿酸
    purine_trione_chart(@member.id,"","")
    # 胆固醇
    cholesterin_chart(@member.id,"","")
    # 体温
    body_temperature_chart(@member.id,"","")
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(member_params)
      flash[:success] = "恭喜您完善资料成功！"
      redirect_to members_path
    else
      flash[:danger] = "修改失败，再来一次。"
      redirect_to :back
    end
  end

  def bundling_doctor
    if current_user.update_attribute(:doctor_id, params[:doctor_id])
      render :json => {:result=>true}.to_json
    else
      render :json => {:result=>false}.to_json
    end
  end

  def send_msg_doc
    member = current_user
    msg = DoctorCommunicateMember.new(doctor_id:member.doctor_id,msg:params[:commiunicate_msg],member_id:member.id,sending:member.class.to_s)
    respond_to do |format|
      if msg.save
        format.html { redirect_to :back }
        format.js {render "members/update/communicate"}
      else
        format.html { redirect_to :back }
        format.js {render "members/update/communicate"}
      end
    end
  end

  def get_new_msg_num
    time = params[:time]
    # puts "----------#{time}----#{Time.now}--------"
    member = current_user
    num = DoctorCommunicateMember.get_two_communicate(member.doctor_id,member.id).get_m_new_msg(Time.parse(time)).get_who_send("Doctor").count
    render :json => {:number=>num}.to_json
  end

  def show
  end

  def adjust_month_chart
    @member_id = params[:member_id]
    @tyle = params[:tyle]
    act = params[:act]
    @next_month = (Time.parse(act + "-01") + 1.month).strftime('%Y-%m-%d')[0,7]
    @previous_month = (Time.parse(act + "-01") - 1.month).strftime('%Y-%m-%d')[0,7]
    pre_time = act+"-01 00:00:01"
    last_time = Date.new(act[0,4].to_i,act[5,7].to_i,-1).strftime('%Y-%m-%d')+" 23:59:59"
    #血压图
    blood_pressure_chart(@member_id,pre_time,last_time) if @tyle == "blood_pressures"
    # 血糖值
    blood_sugar_chart(@member_id,pre_time,last_time) if @tyle == "blood_sugars"
    # # 尿酸
    purine_trione_chart(@member_id,pre_time,last_time) if @tyle == "purine_trione"
    # # 胆固醇
    cholesterin_chart(@member_id,pre_time,last_time) if @tyle == "cholesterin"
    # 体温
    body_temperature_chart(@member_id,pre_time,last_time) if @tyle == "body_temperature"
    # 异步刷新
    respond_to do |format|
      format.html { redirect_to 'members' }
      format.js {render "members/update/blood_pressure"} if @tyle == "blood_pressures"
      format.js {render "members/update/blood_sugar"} if @tyle == "blood_sugars"
      format.js {render "members/update/purine_trione"} if @tyle == "purine_trione"
      format.js {render "members/update/cholesterin"} if @tyle == "cholesterin"
      format.js {render "members/update/body_temperature"} if @tyle == "body_temperature"
    end
  end

  private
    def member_params
      permited=params.require(:member).permit(:name,:birthday,:health,:password,:password_confirmation,:avatar,:sex,:building,:unit,:house,:tel)
      if params[:sex] then permited[:sex]= "男" else  permited[:sex]= "女" end
      permited
    end
    # 血压
    def blood_pressure_chart(member_id,pre_time,last_time)
      @member = Member.find(member_id)
      @pre_time = pre_time.blank? ? Time.now.to_s[0,7]+"-01 00:00:01" : pre_time
      @last_time = last_time.blank? ? Time.now : last_time
      @time = @member.blood_pressure_time_data(@pre_time,@last_time)
      @tick_interval = @member.blood_pressure_tick_interval(@pre_time,@last_time)
      @data1 = @member.get_systolic(@pre_time,@last_time)
      @data2 = @member.get_diastolic(@pre_time,@last_time)
      @blood_pressure_chart = LazyHighCharts::HighChart.new('spline') do |f|
          f.chart({:defaultSeriesType=>"spline" } )
          f.options[:title][:text] = "#{@last_time.to_s[0,7]}月内血压趋势"
          f.legend(enabled: false) 
          f.x_axis(:type=>'datetime',:gridLineWidth=> 0,:categories=> @time,:tickInterval => @tick_interval)
          f.y_axis(:title=>{
            :text=>'血压（mmHg）'
            },
            :min=> 0,
            :minorGridLineWidth=> 1,
            :gridLineWidth=> 1,
            :plotLines=> [{
                      :value=> 0,
                      :width=> 1,
                      :color=> '#808080'
                  }]
            )
          f.tooltip(:valueSuffix=>'mmHg')
          f.plot_options(
            :spline=>{
              :lineWidth=>4,
              :states=>{
                :hover=>{
                  :lineWidth=>6
                }
              },
              :marker=>{:enabled=>false},
            }
          )

          f.series(
            :type=> 'spline',
            :name=> '收缩压',
            :data=> @data1
            
           )
          f.series(
            :type=> 'spline',
            :name=> '舒张压',
            :data=> @data2
          )
          f.navigation(:menuItemStyle=>{:fontSize=>'10px'})
      end
      return @blood_pressure_chart
    end
    # 血糖
    def blood_sugar_chart(member_id,pre_time,last_time)
      @member = Member.find(member_id)
      @pre_time = pre_time.blank? ? Time.now.to_s[0,7]+"-01 00:00:01" : pre_time
      @last_time = last_time.blank? ? Time.now : last_time

      @time = @member.blood_sugars_time_data(@pre_time,@last_time)
      @tick_interval = @member.blood_sugars_tick_interval(@pre_time,@last_time)
      @data1 = @member.get_eated_blood_sugars_result(@pre_time,@last_time)
      @data2 = @member.get_no_eat_blood_sugars_result(@pre_time,@last_time)

      @blood_sugar_chart = LazyHighCharts::HighChart.new('spline') do |f|
          f.chart({:defaultSeriesType=>"spline" } )
          f.options[:title][:text] = "#{@last_time.to_s[0,7]}月内血糖趋势"
          f.legend(enabled: false) 
          f.x_axis(:type=>'datetime',:gridLineWidth=> 0,:categories=> @time,:tickInterval => @tick_interval)
          f.y_axis(:title=>{
            :text=>'血糖（mmol/L）'
            },
            :min=> 0,
            :minorGridLineWidth=> 1,
            :gridLineWidth=> 1,
            :plotLines=> [{
                      :value=> 0,
                      :width=> 1,
                      :color=> '#808080'
                  }]
            )
          f.tooltip(:valueSuffix=>'mmol/L')
          f.plot_options(
            :spline=>{
              :lineWidth=>4,
              :states=>{
                :hover=>{
                  :lineWidth=>6
                }
              },
              :marker=>{:enabled=>false},
            }
          )
          f.series(
            :type=> 'spline',
            :name=> '血糖值(餐后)',
            :data=> @data1
            
           )
          f.series(
            :type=> 'spline',
            :name=> '血糖值(餐前)',
            :data=> @data2
            
           )
          f.navigation(:menuItemStyle=>{:fontSize=>'10px'})
      end
      return @blood_sugar_chart
    end
    # 尿酸
    def purine_trione_chart(member_id,pre_time,last_time)
      @member = Member.find(member_id)
      @pre_time = pre_time.blank? ? Time.now.to_s[0,7]+"-01 00:00:01" : pre_time
      @last_time = last_time.blank? ? Time.now : last_time

      @time = @member.purine_trione_time_data(@pre_time,@last_time)
      @tick_interval = @member.purine_trione_tick_interval(@pre_time,@last_time)
      @data1 = @member.get_eated_purine_trione_result(@pre_time,@last_time)
      @data2 = @member.get_no_eat_purine_trione_result(@pre_time,@last_time)

      @purine_trione_chart = LazyHighCharts::HighChart.new('spline') do |f|
          f.chart({:defaultSeriesType=>"spline" } )
          f.options[:title][:text] = "#{@last_time.to_s[0,7]}月内尿酸趋势"
          f.legend(enabled: false) 
          f.x_axis(:type=>'datetime',:gridLineWidth=> 0,:categories=> @time,:tickInterval => @tick_interval)
          f.y_axis(:title=>{
            :text=>'尿酸（umol/L）'
            },
            :min=> 0,
            :minorGridLineWidth=> 1,
            :gridLineWidth=> 1,
            :plotLines=> [{
                      :value=> 0,
                      :width=> 1,
                      :color=> '#808080'
                  }]
            )
          f.tooltip(:valueSuffix=>'umol/L')
          f.plot_options(
            :spline=>{
              :lineWidth=>4,
              :states=>{
                :hover=>{
                  :lineWidth=>6
                }
              },
              :marker=>{:enabled=>false},
            }
          )
          f.series(
            :type=> 'spline',
            :name=> '尿酸值(餐后)',
            :data=> @data1
            
           )
          f.series(
            :type=> 'spline',
            :name=> '尿酸值(餐前)',
            :data=> @data2
          )
          f.navigation(:menuItemStyle=>{:fontSize=>'10px'})
      end
      return @purine_trione_chart
    end
    # 胆固醇
    def cholesterin_chart(member_id,pre_time,last_time)
      @member = Member.find(member_id)
      @pre_time = pre_time.blank? ? Time.now.to_s[0,7]+"-01 00:00:01" : pre_time
      @last_time = last_time.blank? ? Time.now : last_time

      @time = @member.cholesterin_time_data(@pre_time,@last_time)
      @tick_interval = @member.cholesterin_tick_interval(@pre_time,@last_time)
      @data1 = @member.get_eated_cholesterin_result(@pre_time,@last_time)
      @data2 = @member.get_no_eat_cholesterin_result(@pre_time,@last_time)

      @cholesterin_chart = LazyHighCharts::HighChart.new('spline') do |f|
          f.chart({:defaultSeriesType=>"spline" } )
          f.options[:title][:text] = "#{@last_time.to_s[0,7]}月内胆固醇趋势"
          f.legend(enabled: false) 
          f.x_axis(:type=>'datetime',:gridLineWidth=> 0,:categories=> @time,:tickInterval => @tick_interval)
          f.y_axis(:title=>{
            :text=>'胆固醇（mmol/L）'
            },
            :min=> 0,
            :minorGridLineWidth=> 1,
            :gridLineWidth=> 1,
            :plotLines=> [{
                      :value=> 0,
                      :width=> 1,
                      :color=> '#808080'
                  }]
            )
          f.tooltip(:valueSuffix=>'mmol/L')
          f.plot_options(
            :spline=>{
              :lineWidth=>4,
              :states=>{
                :hover=>{
                  :lineWidth=>6
                }
              },
              :marker=>{:enabled=>false},
            }
          )
          f.series(
            :type=> 'spline',
            :name=> '胆固醇(餐后)',
            :data=> @data1
            
           )
          f.series(
            :type=> 'spline',
            :name=> '胆固醇(餐前)',
            :data=> @data2
            
           )
          f.navigation(:menuItemStyle=>{:fontSize=>'10px'})
      end
      return @cholesterin_chart
    end
    # 体温
    def body_temperature_chart(member_id,pre_time,last_time)
      @member = Member.find(member_id)
      @pre_time = pre_time.blank? ? Time.now.to_s[0,7]+"-01 00:00:01" : pre_time
      @last_time = last_time.blank? ? Time.now : last_time

      @time = @member.body_temperature_time_data(@pre_time,@last_time)
      @tick_interval = @member.body_temperature_tick_interval(@pre_time,@last_time)
      @data1 = @member.get_body_temperature_result(@pre_time,@last_time)

      @body_temperature_chart = LazyHighCharts::HighChart.new('spline') do |f|
          f.chart({:defaultSeriesType=>"spline" } )
          f.options[:title][:text] = "#{@last_time.to_s[0,7]}月内体温趋势"
          f.legend(enabled: false) 
          f.x_axis(:type=>'datetime',:gridLineWidth=> 0,:categories=> @time,:tickInterval => @tick_interval)
          f.y_axis(:title=>{
            :text=>'体温（℃ 摄氏度）'
            },
            :min=> 0,
            :minorGridLineWidth=> 1,
            :gridLineWidth=> 1,
            :plotLines=> [{
                      :value=> 0,
                      :width=> 1,
                      :color=> '#808080'
                  }]
            )
          f.tooltip(:valueSuffix=>'mmol/L')
          f.plot_options(
            :spline=>{
              :lineWidth=>4,
              :states=>{
                :hover=>{
                  :lineWidth=>6
                }
              },
              :marker=>{:enabled=>false},
            }
          )
          f.series(
            :type=> 'spline',
            :name=> '体温',
            :data=> @data1
            
           )
          f.navigation(:menuItemStyle=>{:fontSize=>'10px'})
      end
      return @body_temperature_chart
    end
end
