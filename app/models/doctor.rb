class Doctor < ActiveRecord::Base
  # 密码加密
  has_secure_password
  # 头像上传
  mount_uploader :avatar, AvatarUploader
  
  has_many :members
  has_many :doctor_communicate_members
end
