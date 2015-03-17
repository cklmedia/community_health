class CreateDiabetes < ActiveRecord::Migration
  def change
    create_table :diabetes do |t|
    	t.integer  :member_id
	    t.integer  :age
	    t.integer  :sex
	    t.integer  :level
	    t.integer  :risk
	    t.string   :name
	    t.string   :remark
	    t.string   :expert_comments
	    t.string   :device_type
	    t.string   :team
	    t.decimal  :IR
	    t.decimal  :DC
	    t.decimal  :IGT
	    t.decimal  :Fsi
	    t.decimal  :height
	    t.decimal  :Cn
	    t.datetime :operation_time
	      t.timestamps
    end
  end
end
