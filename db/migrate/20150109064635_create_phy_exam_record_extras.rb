class CreatePhyExamRecordExtras < ActiveRecord::Migration
  def change
    create_table :phy_exam_record_extras do |t|
      t.integer  :phy_exam_record_id
      t.integer  :category_id
      t.string   :doctor
      t.text     :content
      t.timestamps
    end
  end
end
