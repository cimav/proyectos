class Theme < ApplicationRecord
  has_many :projects, through: :project_themes
end
