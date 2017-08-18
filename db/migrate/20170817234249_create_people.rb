class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.integer :people_type
      t.string :name
      t.string :email
      t.string :phone
      t.text :notes
      t.string :image
      t.integer :attachable_id
      t.string  :attachable_type

      t.timestamps
    end
  end
end
