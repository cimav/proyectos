class Project < ApplicationRecord
  belongs_to :manager, :foreign_key => "manager_id", :class_name => "User"
  belongs_to :agent, :foreign_key => "agent_id", :class_name => "User"
  belongs_to :department
  belongs_to :project_type
  belongs_to :client
  belongs_to :business_unit
end
