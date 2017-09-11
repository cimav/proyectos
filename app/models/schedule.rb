class Schedule < ApplicationRecord
  belongs_to :project
  belongs_to :user

  PROJECT_END = 99

  TYPE_TEXT = {
    PROJECT_END   => "Fecha Termino"
  }

  def type_text
    TYPE_TEXT[schedule_type.to_i]
  end
end