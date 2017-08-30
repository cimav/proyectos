# coding: utf-8
class User < ApplicationRecord
  belongs_to :department

  STATUS_SYSTEM   = 0
  STATUS_ACTIVE   = 1
  STATUS_INACTIVE = 2

  ACCESS_USER = 0
  ACCESS_ADMIN    = 1

  ACCESS_TYPE = {
    ACCESS_USER => "Usuario",
    ACCESS_ADMIN    => "Administrador"
  }

  def picture
  	"http://cimav.edu.mx/foto/#{email.split('@')[0]}/120"
  end

  def full_name
  	name
  end
  
end
