class HomeController < ApplicationController
  def index
    if current_user.class.to_s == "Doctor"
      get_member_num
      get_nums
    end
  end
  private

    def get_member_num
      @member_num = current_user.members.count
    end

    def get_nums
      @phy_num = 0
      @house_num = 0
      @msg_num = 0
      @tishineng = 0
      @zhonngyi = 0
      current_user.members do |m|
      	# 体检档案
      	# @phy_num + = m.

      # 居家检测
  		@house_num += m.blood_pressures.count
  		@house_num += m.blood_sugars.count
  		@house_num += m.purine_triones.count
  		@house_num += m.cholesterins.count
  		@house_num += m.body_temperatures.count
  		# 留言
  		@msg_num += m.doctor_communicate_members.count
  		# 中医
  		# @zhongyi += m.
      end
      return @phy_num,@house_num,@msg_num,@tishineng,@zhonngyi
    end
end
