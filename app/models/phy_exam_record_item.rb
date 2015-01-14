class PhyExamRecordItem < ActiveRecord::Base
  belongs_to :phy_exam_record, :class_name=>"PhyExamRecord"
  belongs_to :phy_exam_tpl_item, :class_name=>"PhyExamTplItem"
  scope :get_record_items, -> (category_id,phy_exam_record_id) { 
    where(:category_id => category_id, :phy_exam_record_id => phy_exam_record_id)
  }
end
