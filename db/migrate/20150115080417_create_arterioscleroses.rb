class CreateArterioscleroses < ActiveRecord::Migration
  def change
    create_table :arterioscleroses do |t|
    	t.integer  :member_id
	    t.string   :name
	    t.string   :team
	    t.integer  :sex
	    t.integer  :age
	    t.decimal  :height
	    t.decimal  :HR
	    t.decimal  :Rb_DIA
	    t.decimal  :Rb_SYS
	    t.decimal  :Lb_SYS
	    t.decimal  :Lb_DIA
	    t.decimal  :Ra_SYS
	    t.decimal  :Ra_DIA
	    t.decimal  :La_SYS
	    t.decimal  :La_DIA
	    t.decimal  :R_stiffness
	    t.decimal  :L_stiffness
	    t.decimal  :L_vasoocclusion
	    t.decimal  :R_vasoocclusion
	    t.datetime :operation_time
	    t.string   :remark
	    t.string   :expert_comments
	    t.string   :device_type
      t.timestamps
    end
  end
end
