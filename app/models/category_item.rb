class CategoryItem < ActiveRecord::Base
  belongs_to :category
  has_many :phy_exam_tpl_items
  scope :group_category, ->(category_id) { where category_id: category_id }
  scope :get_tpl_item, ->(tpl_id) { joins(:phy_exam_tpl_items).where("phy_exam_tpl_items.phy_exam_tpl_id = ?",tpl_id)}
end
