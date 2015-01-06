class CreateBloodPressures < ActiveRecord::Migration
  def change
    create_table :blood_pressures do |t|
      t.integer  :member_id
      t.integer  :diastolic
      t.integer  :systolic
      t.integer  :pulse

      t.timestamps
    end
  end
end
