class CreatePhyExamRecordItems < ActiveRecord::Migration
  def change
    create_table :phy_exam_record_items do |t|
      t.integer  :phy_exam_record_id
      t.integer  :phy_exam_tpl_item_id
      t.string   :result
      t.integer  :category_id
      t.string   :decide
      t.timestamps
    end
  end
end
