class CreateRequiredFolders < ActiveRecord::Migration[5.1]
  def change
    create_table :required_folders do |t|
      t.references :project_type, foreign_key: true
      t.integer :parent_folder
      t.string :name
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
