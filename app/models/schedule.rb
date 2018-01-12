class Schedule < ApplicationRecord
  belongs_to :project
  belongs_to :user

  DATE = 1
  PROJECT_START = 98
  PROJECT_END = 99

  TYPE_TEXT = {
    DATE => "Fecha importante",
    PROJECT_START   => "Fecha Inicio",
    PROJECT_END   => "Fecha Termino"
  }

  ACTIVE = 1
  DELETED = 2

  def type_text
    TYPE_TEXT[schedule_type.to_i]
  end
end