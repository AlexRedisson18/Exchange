class DeleteStatusFromOffers < ActiveRecord::Migration[6.0]
  def change
    remove_column :offers, :status, :string
  end
end
