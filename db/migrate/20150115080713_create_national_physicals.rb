class CreateNationalPhysicals < ActiveRecord::Migration
  def change
    create_table :national_physicals do |t|
		t.integer  :member_id
	    t.integer  :age
	    t.integer  :sex
	    t.integer  :weight_score
	    t.integer  :BMR_score
	    t.integer  :body_flexion_score
	    t.integer  :step_index_score
	    t.integer  :FVC_score
	    t.integer  :vertical_jump_score
	    t.integer  :push_up_score
	    t.integer  :grip_score
	    t.integer  :one_leg_standing_score
	    t.integer  :reaction_score
	    t.integer  :situp_score
	    t.string   :name
	    t.string   :team
	    t.string   :remark
	    t.string   :expert_comments
	    t.string   :device_type
	    t.decimal  :weight
	    t.decimal  :BMI
	    t.decimal  :FVC
	    t.decimal  :BMR
	    t.decimal  :height
	    t.decimal  :grip
	    t.decimal  :body_flexion
	    t.decimal  :step_index
	    t.decimal  :vertical_jump
	    t.decimal  :push_up
	    t.decimal  :reaction
	    t.decimal  :situp
	    t.datetime :operation_time
	    t.decimal  :one_leg_standing
      t.timestamps
    end
  end
end
