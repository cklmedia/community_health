class CreatePhyExamRecords < ActiveRecord::Migration
  def change
    create_table :phy_exam_records do |t|
      t.integer  :phy_exam_tpl_id
      t.integer  :member_id
      t.date     :phy_exam_date
      t.integer  :doctor_id
      t.string   :phy_records_file
      t.text     :phy_tpl_conclusion
      t.text     :phy_tpl_advise
      t.timestamps
    end
  end
end
