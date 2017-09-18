class Project < ApplicationRecord
  belongs_to :manager, :foreign_key => "manager_id", :class_name => "User"
  belongs_to :agent, :foreign_key => "agent_id", :class_name => "User"
  belongs_to :department
  belongs_to :project_type
  belongs_to :client
  belongs_to :business_unit
  belongs_to :project_status, :foreign_key => "status", :class_name => "ProjectStatus"
  has_many   :schedules
  has_many   :messages


  before_validation :set_extra, on: :create

  RESEARCH_BASIC   = 1
  RESEARCH_APPLIED = 2
  RESEARCH_TECH    = 3

  RESEARCH_TYPE = {
    RESEARCH_BASIC   => "Básica",
    RESEARCH_APPLIED => "Aplicada",
    RESEARCH_TECH    => "Desarrollo Tecnológico"
  }


  def research_text
    RESEARCH_TYPE[research_type.to_i]
  end


  def sale_price
    0
  end

  def budget
    1200100
  end

  def budget_expended
    budget / 3
  end

  def budget_obligated
    0
  end

  def budget_available
    (budget - budget_expended - budget_obligated)
  end

  def end_schedule
    schedules.where(schedule_type: Schedule::PROJECT_END).first 
  end

  private

    def set_extra
  	  self.department_id = self.manager.department_id
      self.name = self.internal_name

      first_status = self.project_type.project_statuses.where(position: 1).first
      self.status = first_status.id
    end

end
