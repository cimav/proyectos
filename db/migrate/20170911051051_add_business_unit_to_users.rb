class AddBusinessUnitToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :business_unit_id, :integer
  end
end
