class Member < ActiveRecord::Base
  # 密码加密
  has_secure_password
  # 头像上传
  mount_uploader :avatar, AvatarUploader
  
  belongs_to :doctor
  has_many :doctor_communicate_members
  has_many :blood_pressures
  has_many :blood_sugars
  has_many :purine_triones
  has_many :cholesterins
  has_many :body_temperatures

  def blood_pressure_time_data(start_time,end_time)
    times = BloodPressure.find_by_sql(["select * from blood_pressures where member_id = ? and created_at >= ? and created_at <= ? order by created_at",self.id,start_time,end_time])
    times.map { |time| [time[:created_at].strftime('%Y-%m-%d') ] }
  end

  def blood_pressure_tick_interval(start_time,end_time)
    count = BloodPressure.find_by_sql(["select * from blood_pressures where member_id = ? and created_at >= ? and created_at <= ? order by created_at",self.id,start_time,end_time]).count
    interval = count/6 +1
    return interval
  end

  def get_systolic(start_time,end_time)
    datas = BloodPressure.find_by_sql(["select * from blood_pressures where member_id = ? and created_at >= ? and created_at <= ? order by created_at",self.id,start_time,end_time])
    datas.map { |data| [data[:created_at].strftime("%Y-%m-%d"" %H:%M"),data[:systolic]] }
  end

  def get_diastolic(start_time,end_time)
    datas = BloodPressure.find_by_sql(["select * from blood_pressures where member_id = ? and created_at >= ? and created_at <= ? order by created_at",self.id,start_time,end_time])
    datas.map { |data| [data[:created_at].strftime("%Y-%m-%d"" %H:%M"),data[:diastolic]] }
  end
  # 血糖 highcharts处理
  def blood_sugars_time_data(start_time,end_time)
    times = BloodSugar.find_by_sql(["select * from blood_sugars where member_id = ? and created_at >= ? and created_at <= ? order by created_at",self.id,start_time,end_time])
    times.map { |time| [time[:created_at].strftime('%Y-%m-%d') ] }
  end
  def blood_sugars_tick_interval(start_time,end_time)
    count = BloodSugar.find_by_sql(["select * from blood_sugars where member_id = ? and created_at >= ? and created_at <= ? order by created_at",self.id,start_time,end_time]).count
    interval = count/6 +1
    return interval
  end
  def get_eated_blood_sugars_result(start_time,end_time)
    datas = BloodSugar.find_by_sql(["select * from blood_sugars where member_id = ? and created_at >= ? and created_at <= ? and test_type > 0 order by created_at",self.id,start_time,end_time])
    datas.map { |data| [data[:created_at].strftime("%Y-%m-%d"" %H:%M"),data[:result]] }
  end
  def get_no_eat_blood_sugars_result(start_time,end_time)
    datas = BloodSugar.find_by_sql(["select * from blood_sugars where member_id = ? and created_at >= ? and created_at <= ? and test_type = 0 order by created_at",self.id,start_time,end_time])
    datas.map { |data| [data[:created_at].strftime("%Y-%m-%d"" %H:%M"),data[:result]] }
  end
    # 尿酸 highcharts处理
  def purine_trione_time_data(start_time,end_time)
    times = PurineTrione.find_by_sql(["select * from purine_triones where member_id = ? and created_at >= ? and created_at <= ? order by created_at",self.id,start_time,end_time])
    times.map { |time| [time[:created_at].strftime('%Y-%m-%d') ] }
  end
  def purine_trione_tick_interval(start_time,end_time)
    count = PurineTrione.find_by_sql(["select * from purine_triones where member_id = ? and created_at >= ? and created_at <= ? order by created_at",self.id,start_time,end_time]).count
    interval = count/6 +1
    return interval
  end
  def get_eated_purine_trione_result(start_time,end_time)
    datas = PurineTrione.find_by_sql(["select * from purine_triones where member_id = ? and created_at >= ? and created_at <= ? and test_type = 1 order by created_at",self.id,start_time,end_time])
    datas.map { |data| [data[:created_at].strftime("%Y-%m-%d"" %H:%M"),data[:result]] }
  end
  def get_no_eat_purine_trione_result(start_time,end_time)
    datas = PurineTrione.find_by_sql(["select * from purine_triones where member_id = ? and created_at >= ? and created_at <= ? and test_type = 0 order by created_at",self.id,start_time,end_time])
    datas.map { |data| [data[:created_at].strftime("%Y-%m-%d"" %H:%M"),data[:result]] }
  end
  # 胆固醇 highcharts处理
  def cholesterin_time_data(start_time,end_time)
    times = Cholesterin.find_by_sql(["select * from cholesterins where member_id = ? and created_at >= ? and created_at <= ? order by created_at",self.id,start_time,end_time])
    times.map { |time| [time[:created_at].strftime('%Y-%m-%d') ] }
  end
  def cholesterin_tick_interval(start_time,end_time)
    count = Cholesterin.find_by_sql(["select * from cholesterins where member_id = ? and created_at >= ? and created_at <= ? order by created_at",self.id,start_time,end_time]).count
    interval = count/6 +1
    return interval
  end
  def get_eated_cholesterin_result(start_time,end_time)
    datas = Cholesterin.find_by_sql(["select * from cholesterins where member_id = ? and created_at >= ? and created_at <= ? and test_type = 1 order by created_at",self.id,start_time,end_time])
    datas.map { |data| [data[:created_at].strftime("%Y-%m-%d"" %H:%M"),data[:result]] }
  end
  def get_no_eat_cholesterin_result(start_time,end_time)
    datas = Cholesterin.find_by_sql(["select * from cholesterins where member_id = ? and created_at >= ? and created_at <= ? and test_type = 0 order by created_at",self.id,start_time,end_time])
    datas.map { |data| [data[:created_at].strftime("%Y-%m-%d"" %H:%M"),data[:result]] }
  end
  # 体温 highcharts处理
  def body_temperature_time_data(start_time,end_time)
    times = BodyTemperature.find_by_sql(["select * from body_temperatures where member_id = ? and created_at >= ? and created_at <= ? order by created_at",self.id,start_time,end_time])
    times.map { |time| [time[:created_at].strftime('%Y-%m-%d') ] }
  end
  def body_temperature_tick_interval(start_time,end_time)
    count = BodyTemperature.find_by_sql(["select * from body_temperatures where member_id = ? and created_at >= ? and created_at <= ? order by created_at",self.id,start_time,end_time]).count
    interval = count/6 +1
    return interval
  end
  def get_body_temperature_result(start_time,end_time)
    datas = BodyTemperature.find_by_sql(["select * from body_temperatures where member_id = ? and created_at >= ? and created_at <= ? order by created_at",self.id,start_time,end_time])
    datas.map { |data| [data[:created_at].strftime("%Y-%m-%d"" %H:%M"),data[:result]] }
  end
end
