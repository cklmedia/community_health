class CreateHealthAerobics < ActiveRecord::Migration
  def change
    create_table :health_aerobics do |t|
		t.integer  :member_id
	    t.string   :name
	    t.string   :team
	    t.integer  :sex
	    t.integer  :age
	    t.text     :Hrs
	    t.text     :HtHR
	    t.datetime :operation_time
	    t.string   :remark
	    t.string   :expert_comments
	    t.string   :device_type
	    t.decimal  :max_oxygen
	    t.decimal  :height
      t.timestamps
    end
  end
end
