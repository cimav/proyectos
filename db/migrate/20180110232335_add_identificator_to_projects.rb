class AddIdentificatorToProjects < ActiveRecord::Migration[5.1]
  def change
  	add_column :projects, :consecutive, :integer
  	add_column :projects, :identificator, :string
  end
end
