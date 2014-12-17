class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :password_digest
      t.string :avatar
      t.string :tel
      t.string :sex
      t.text :introduce


      t.timestamps
    end
  end
end
