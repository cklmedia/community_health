class CreateBodyTemperatures < ActiveRecord::Migration
  def change
    create_table :body_temperatures do |t|
      t.float    :result
      t.integer  :member_id
      t.datetime :measure_time

      t.timestamps
    end
  end
end
