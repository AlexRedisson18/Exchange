class CreateLots < ActiveRecord::Migration[6.0]
  def change
    create_table :lots do |t|
      t.string :title
      t.string :description
      t.string :image
      t.string :status
      t.string :state
      t.string :price
      t.belongs_to :category
      t.belongs_to :user

      t.timestamps
    end
  end
end
