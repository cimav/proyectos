class AddProjectIdToFolders < ActiveRecord::Migration[5.1]
  def change
  	add_column :project_folders, :project_id, :integer
  end
end
