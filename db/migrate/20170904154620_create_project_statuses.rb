class CreateProjectStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :project_statuses do |t|
      t.string :name
      t.integer :position
      t.references :project_type, foreign_key: true

      t.timestamps
    end
  end
end
