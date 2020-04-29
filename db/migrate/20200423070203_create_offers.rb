class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :status
      t.belongs_to :requested_lot, null: false
      t.belongs_to :suggested_lot, null: false

      t.timestamps
    end
  end
end
