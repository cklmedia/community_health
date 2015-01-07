class CreatePhyExamTpls < ActiveRecord::Migration
  def change
    create_table :phy_exam_tpls do |t|
      t.string   :name
      t.string   :description
      t.string   :agency
      t.timestamps
    end
  end
end
