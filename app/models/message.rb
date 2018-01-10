class Message < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  ACTIVE = 1
  DELETED = 2

  TYPE_MESSAGE = 1
  TYPE_STATUS = 2
  
end
