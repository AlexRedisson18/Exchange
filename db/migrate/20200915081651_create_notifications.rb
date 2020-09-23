class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.belongs_to :lot
      t.belongs_to :my_lot
      t.integer :status, default: 0
      t.integer :kind, null: false
      t.timestamps
    end
  end
end
