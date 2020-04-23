class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :status
      t.belongs_to :requested_lot
      t.belongs_to :suggested_lot

      t.timestamps
    end
  end
end
