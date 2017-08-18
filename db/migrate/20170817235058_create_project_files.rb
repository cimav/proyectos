class CreateProjectFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :project_files do |t|
      t.string :name
      t.references :project_folder, foreign_key: true
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
