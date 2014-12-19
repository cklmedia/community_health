class CreateDoctorCommunicateMembers < ActiveRecord::Migration
  def change
    create_table :doctor_communicate_members do |t|
 	  t.integer :doctor_id
 	  t.integer :member_id
 	  t.text :content
 	  t.string :send
 	  
      t.timestamps
    end
  end
end
