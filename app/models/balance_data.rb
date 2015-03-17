class BalanceData < ActiveRecord::Base
  belongs_to :balance
  def get_pro_name(performance_name,single)
  	eye = "无"
  	feet = ""
  	if performance_name == "Eyes Open Unstable"
  	  eye ="睁眼"
  	elsif performance_name == "Eyes Closed Unstable"
  		eye ="闭眼"
  	end
  	if single == 0 || single == "0"
  	  feet ="单脚"
  	elsif single == 1 || single == "1"
  		feet ="双脚"
  	end
  	feet+eye
  end
end
