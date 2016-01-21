class AddAvailableQuantityToProducts < ActiveRecord::Migration
  def change
    add_column :products, :available_quantity, :integer
  end
end
