class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.references :department
      t.string :status
      t.integer :supervisor_id

      t.timestamps
    end
  end
end
