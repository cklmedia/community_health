class CreateCategoryItems < ActiveRecord::Migration
  def change
    create_table :category_items do |t|
      t.string   :name
      t.integer  :category_id
      t.string   :item_tag
      t.integer  :definition_type
      t.integer  :result_type
      t.string   :description

      t.timestamps
    end
  end
end
