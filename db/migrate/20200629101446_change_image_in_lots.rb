class ChangeImageInLots < ActiveRecord::Migration[6.0]
  def change
    change_column :lots, :image, :string, null: true
  end
end
