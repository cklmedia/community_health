class CategoryItem < ActiveRecord::Base
  belongs_to :category
  has_many :phy_exam_tpl_items
  scope :group_category, ->(category_id) { where category_id: category_id }
end
