class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :city
      t.string :street

      t.timestamps
    end
  end
end
