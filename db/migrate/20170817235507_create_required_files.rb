class CreateRequiredFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :required_files do |t|
      t.references :project_type, foreign_key: true
      t.references :required_folder, foreign_key: true
      t.string :name
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
