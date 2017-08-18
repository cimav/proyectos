class ProjectPerson < ApplicationRecord
  belongs_to :project
  belongs_to :people
end
