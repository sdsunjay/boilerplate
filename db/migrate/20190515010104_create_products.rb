class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false, default: ""
      t.text :description
      t.string :style
      t.string :brand
      t.integer :product_type, :limit => 2, null: false, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
