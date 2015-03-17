class CreateHealthBmds < ActiveRecord::Migration
  def change
    create_table :health_bmds do |t|
        t.integer  :member_id
	    t.string   :name
	    t.string   :remark
	    t.string   :expert_comments
	    t.string   :device_type
	    t.string   :team
	    t.integer  :sex
	    t.integer  :age
	    t.decimal  :TI
	    t.decimal  :Z
	    t.decimal  :height
	    t.decimal  :BMD
	    t.datetime :operation_time

      t.timestamps
    end
  end
end
