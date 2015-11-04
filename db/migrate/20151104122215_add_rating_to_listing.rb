class AddRatingToListing < ActiveRecord::Migration
  def change
    add_column :listings, :rate, :string
  end
end
