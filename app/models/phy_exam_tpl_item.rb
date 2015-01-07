class PhyExamTplItem < ActiveRecord::Base
  belongs_to :category_item
  belongs_to :phy_exam_tpl
  has_one :phy_exam_stand_result
end
