class PhyExamRecordExtra < ActiveRecord::Base
  belongs_to :category, :class_name=>"Category"
  belongs_to :phy_exam_record, :class_name=>"PhyExamRecord"
  scope :select_extra, -> (category_id,record_id) { where(:category_id => category_id, :phy_exam_record_id => record_id)}
end
