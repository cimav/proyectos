class ProjectFolder < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many   :project_files
end
