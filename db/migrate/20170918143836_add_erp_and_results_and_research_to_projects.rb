class AddErpAndResultsAndResearchToProjects < ActiveRecord::Migration[5.1]
  def change
  	add_column :projects,:results, :text
  	add_column :projects,:erp_number, :string
  	add_column :projects, :research_type, :integer
  end
end
