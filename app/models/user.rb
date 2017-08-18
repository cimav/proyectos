class User < ApplicationRecord
  belongs_to :department

  def picture
  	"http://cimav.edu.mx/foto/#{email.split('@')[0]}/32"
  end
end
