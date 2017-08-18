class CreateProjectThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :project_themes do |t|
      t.references :project, foreign_key: true
      t.references :theme, foreign_key: true

      t.timestamps
    end
  end
end
