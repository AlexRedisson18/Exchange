class AddImagesJsonToLots < ActiveRecord::Migration[6.0]
  def change
    add_column :lots, :images, :json
  end
end
