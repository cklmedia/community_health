class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
    	t.integer  :o_id
	    t.string   :team
	    t.decimal  :height
	    t.string   :remark
	    t.string   :valuation
	    t.string   :expert_comments
	    t.datetime :operation_time
	    t.integer  :member_id
	    t.string   :name
	    t.integer  :age
	    t.integer  :sex
	    t.string   :protocol
	    t.integer  :perf_times
	    t.integer  :optimistic_lock_field
	    t.integer  :GC_record
      t.timestamps
    end
  end
end
