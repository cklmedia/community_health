class CategoryItem < ActiveRecord::Base
  belongs_to :category
  has_many :phy_exam_tpl_items
end
