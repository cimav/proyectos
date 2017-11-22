class Person < ApplicationRecord
  belongs_to :attachable, :polymorphic => true
  belongs_to :project_person, class_name: 'ProjectPerson', foreign_key: 'person_id'

  def picture
  	"http://cimav.edu.mx/foto/#{email.split('@')[0]}/120"
  end
end
