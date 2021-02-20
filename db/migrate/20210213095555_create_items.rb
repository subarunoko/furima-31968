class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :title,                null: false, default: ""
      t.text       :description,          null: false 
      t.integer    :price,                null: false
      t.integer    :category_id,          null: false
      t.integer    :state_id,             null: false, foreign_key: true
      t.integer    :delivery_fee_id,      null: false, foreign_key: true
      t.integer    :delivery_area_id,     null: false, foreign_key: true
      t.integer    :delivery_days_id,     null: false, foreign_key: true
      t.references :user,                 null: false, foreign_key: true

      t.timestamps
    end
  end
end
