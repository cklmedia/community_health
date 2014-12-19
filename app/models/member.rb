class Member < ActiveRecord::Base
  # 密码加密
  has_secure_password
  # 头像上传
  mount_uploader :avatar, AvatarUploader
  
  belongs_to :doctor
  has_many :doctor_communicate_members
end
