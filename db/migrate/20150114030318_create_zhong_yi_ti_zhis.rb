class CreateZhongYiTiZhis < ActiveRecord::Migration
  def change
    create_table :zhong_yi_ti_zhis do |t|
      t.integer  :member_id
      t.string   :result
      t.integer  :unique_id

      t.timestamps
    end
  end
end
