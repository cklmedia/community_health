class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :password_digest
      t.string :avatar
      t.string :tel
      t.string :sex
      t.integer :doctor_id
      t.date :birthday
      t.text :health
      t.string :building
      t.string :unit
      t.string :house

      t.timestamps
    end
  end
end
