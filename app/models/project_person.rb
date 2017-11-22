class ProjectPerson < ApplicationRecord
  belongs_to :project
  belongs_to :person, :foreign_key => "people_id"
end
