class Category < ActiveRecord::Base
  has_many :category_items
  def get_items(exam_tpl_id)
  	self.category_items.get_tpl_item(exam_tpl_id)
  end
end
