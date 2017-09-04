class AddDescriptionToProjectTypes < ActiveRecord::Migration[5.1]
  def change
  	add_column :project_types,:description,:text
  end
end
