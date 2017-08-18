class ProjectTheme < ApplicationRecord
  belongs_to :project
  belongs_to :theme
end
