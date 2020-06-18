class CreateInterestingCategoriesLotsJoinTable < ActiveRecord::Migration[6.0]
def change
    create_join_table :categories, :lots do |t|
      t.references :interesting_category
      t.references :interested_lot
    end
  end
end
