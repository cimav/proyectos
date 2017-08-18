class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.references :client
      t.string :number
      t.string :internal_name
      t.text :goal
      t.integer :manager_id
      t.integer :agent_id
      t.integer :department_id
      t.integer :business_unit_id
      t.integer :project_type_id
      t.integer :status

      t.timestamps
    end
  end
end
