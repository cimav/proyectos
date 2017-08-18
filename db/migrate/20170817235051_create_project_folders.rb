class CreateProjectFolders < ActiveRecord::Migration[5.1]
  def change
    create_table :project_folders do |t|
      t.string :name
      t.text :description
      t.integer :parent_folder
      t.integer :folder_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
