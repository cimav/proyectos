class User < ApplicationRecord
  belongs_to :department

  STATUS_SYSTEM   = 0
  STATUS_ACTIVE   = 1
  STATUS_INACTIVE = 2

  def picture
  	"http://cimav.edu.mx/foto/#{email.split('@')[0]}/120"
  end
end
