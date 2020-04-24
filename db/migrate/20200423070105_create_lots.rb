class CreateLots < ActiveRecord::Migration[6.0]
  def change
    create_table :lots do |t|
      t.string :title, null: false
      t.string :description
      t.string :image, null: false
      t.integer :status, default: 0
      t.integer :state
      t.integer :price
      t.belongs_to :category
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
