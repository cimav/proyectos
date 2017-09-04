class ProjectType < ApplicationRecord
  has_many :projects
  has_many :project_statuses
end
