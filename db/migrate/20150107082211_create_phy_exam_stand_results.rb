class CreatePhyExamStandResults < ActiveRecord::Migration
  def change
    create_table :phy_exam_stand_results do |t|
      t.string   :name
      t.integer  :phy_exam_tpl_item_id
      t.integer  :definition_type
      t.string   :unit
      t.string   :device
      t.integer  :result_type_id
      t.integer  :normal_max
      t.integer  :normal_min
      t.string   :description
      t.text     :result_text
      t.timestamps
    end
  end
end
