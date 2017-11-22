class Client < ApplicationRecord
  audited
  has_many :projects
  belongs_to :company_size
  belongs_to :industry
  has_many :people, :as => :attachable
end
