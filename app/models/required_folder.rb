class RequiredFolder < ApplicationRecord
  belongs_to :project_type
  belongs_to :user
end
