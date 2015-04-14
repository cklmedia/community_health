class PhyExamRecord < ActiveRecord::Base
  belongs_to :phy_exam_tpl
  belongs_to :member, :class_name=>"Member"
  belongs_to :doctor, :class_name=>"Doctor"
  has_many :phy_exam_record_items, :class_name=>"PhyExamRecordItem",:dependent => :destroy
  has_many :phy_exam_record_extras, :class_name=>"PhyExamRecordExtra",:dependent => :destroy
  scope :select_can_see, ->{
    joins("INNER JOIN members as mb ON (phy_exam_records.member_id = mb.id )").joins("INNER JOIN doctors ON (mb.doctor_id = doctors.id)")
  }
  
end
