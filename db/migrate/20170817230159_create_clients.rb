class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :short_name
      t.string :real_name
      t.text :address
      t.references :company_size
      t.references :industry

      t.timestamps
    end
  end
end
