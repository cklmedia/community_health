class Doctor < ActiveRecord::Base
  # 密码加密
  has_secure_password

  has_many :member
end
