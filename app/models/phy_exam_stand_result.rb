class PhyExamStandResult < ActiveRecord::Base
  belongs_to :result_type
  belongs_to :phy_exam_tpl_item
end
