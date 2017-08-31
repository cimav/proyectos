# coding: utf-8
class User < ApplicationRecord
  belongs_to :department
  belongs_to :supervisor, :foreign_key => "supervisor_id", :class_name => "User"

  STATUS_SYSTEM   = 0
  STATUS_ACTIVE   = 1
  STATUS_INACTIVE = 2

  ACCESS_USER  = 0
  ACCESS_ADMIN = 1

  ACCESS_TYPE = {
    ACCESS_USER  => "Usuario",
    ACCESS_ADMIN => "Administrador"
  }

  STATUS_TEXT = {
    STATUS_SYSTEM   => "SISTEMA",
    STATUS_ACTIVE   => "Activo",
    STATUS_INACTIVE => "Inactivo"
  }

  def access_text
    ACCESS_TYPE[access.to_i]
  end

  def status_text
    STATUS_TEXT[status.to_i]
  end

  def picture
  	"http://cimav.edu.mx/foto/#{email.split('@')[0]}/120"
  end

  def full_name
  	"#{first_name} #{last_name}"
  end
  
end
