class Institution < ApplicationRecord
  has_many :projects, through: :project_institutions
end
