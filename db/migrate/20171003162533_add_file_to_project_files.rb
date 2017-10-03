class AddFileToProjectFiles < ActiveRecord::Migration[5.1]
  def change
  	add_column :project_files, :file, :string
  end
end
