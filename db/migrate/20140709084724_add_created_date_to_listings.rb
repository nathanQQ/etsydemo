class AddCreatedDateToListings < ActiveRecord::Migration
  def change
    add_column :listings, :created_date, :string
  end
end
