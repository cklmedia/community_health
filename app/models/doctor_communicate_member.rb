class DoctorCommunicateMember < ActiveRecord::Base
  belongs_to :member
  belongs_to :doctor
  scope :get_two_communicate, -> (d_id,m_id){where(doctor_id:d_id,member_id:m_id)}
  scope :get_m_new_msg, -> (time){where("created_at > ?",time)}
  scope :get_who_send, -> (class_name){where(sending:class_name)}
end
