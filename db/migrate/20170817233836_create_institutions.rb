class CreateInstitutions < ActiveRecord::Migration[5.1]
  def change
    create_table :institutions do |t|
      t.string :short_name
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
