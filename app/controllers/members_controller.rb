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
    num = DoctorCommunicateMember.get_two_communicate(member.doctor_id,member.id).get_m_new_msg(Time.parse(time)).count
    render :json => {:number=>num}.to_json
  end

  def show

  end

  private
    def member_params
      permited=params.require(:member).permit(:name,:birthday,:health,:password,:password_confirmation,:avatar,:sex,:building,:unit,:house,:tel)
      if params[:sex] then permited[:sex]= "男" else  permited[:sex]= "女" end
      permited
    end
end
