class RemoveImageFromLot < ActiveRecord::Migration[6.0]
  def change
    remove_column :lots, :image
  end
end
