class CreateBalanceData < ActiveRecord::Migration
  def change
    create_table :balance_data do |t|
    	t.integer  :o_id
	    t.integer  :balance_id
	    t.decimal  :STD_velocity
	    t.decimal  :romberg_quotient
	    t.decimal  :mean_x
	    t.decimal  :mean_y
	    t.decimal  :standard_dev_x
	    t.decimal  :standard_dev_y
	    t.decimal  :feft_weight_distribution
	    t.decimal  :right_weight_distribution
	    t.decimal  :trace_length
	    t.decimal  :C90_area2
	    t.integer  :single
	    t.integer  :optimistic_lock_field
	    t.integer  :GC_cecord
	    t.text     :context
	    t.string   :performance_name
      t.timestamps
    end
  end
end
