class Member < ActiveRecord::Base
  # 密码加密
  has_secure_password

  belongs_to :doctor
end
