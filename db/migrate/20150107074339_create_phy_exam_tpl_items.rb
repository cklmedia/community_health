class CreatePhyExamTplItems < ActiveRecord::Migration
  def change
    create_table :phy_exam_tpl_items do |t|
      t.integer  "phy_exam_tpl_id"
      t.integer  "category_item_id"
      t.string   "alias_name"
      t.timestamps
    end
  end
end
