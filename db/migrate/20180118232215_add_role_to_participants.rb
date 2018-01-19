class AddRoleToParticipants < ActiveRecord::Migration[5.1]
  def change
  	add_column :project_participants, :role, :string
  end
end
