class CreateBloodSugars < ActiveRecord::Migration
  def change
    create_table :blood_sugars do |t|
      t.integer  :test_type
      t.float    :result
      t.integer  :member_id
      t.datetime :measure_time

      t.timestamps
    end
  end
end
