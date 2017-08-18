class RequiredFile < ApplicationRecord
  belongs_to :project_type
  belongs_to :required_folder
  belongs_to :user
end
