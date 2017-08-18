class CreateProjectPeople < ActiveRecord::Migration[5.1]
  def change
    create_table :project_people do |t|
      t.references :project, foreign_key: true
      t.references :people, foreign_key: true
      t.string :role
      t.timestamps
    end
  end
end
