class ProjectFile < ApplicationRecord
  belongs_to :project_folder
  belongs_to :user
end
