class Institution < ApplicationRecord
  has_many :projects, through: :project_institutions
  has_many :people, :as => :attachable
end
