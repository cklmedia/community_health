class CreateDoctorCommunicateMembers < ActiveRecord::Migration
  def change
    create_table :doctor_communicate_members do |t|
 	  t.integer :doctor_id
 	  t.integer :member_id
 	  t.text :msg
 	  t.string :sending
 	  
      t.timestamps
    end
  end
end
