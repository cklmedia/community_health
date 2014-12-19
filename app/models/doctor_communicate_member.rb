class DoctorCommunicateMember < ActiveRecord::Base
  belongs_to :member
  belongs_to :doctor
  scope :get_two_communicate, -> (d_id,m_id){where(doctor_id:d_id,member_id:m_id)}
end
