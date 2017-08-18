class Client < ApplicationRecord
  has_many :projects
  belongs_to :company_size
  belongs_to :industry
end
