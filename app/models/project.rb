class Project < ApplicationRecord
  belongs_to :manager, :foreign_key => "manager_id", :class_name => "User"
  belongs_to :agent, :foreign_key => "agent_id", :class_name => "User"
  belongs_to :department
  belongs_to :project_type
  belongs_to :client
  belongs_to :business_unit
  belongs_to :project_status, :foreign_key => "status", :class_name => "ProjectStatus"
  has_many   :schedules


  before_validation :set_extra, on: :create


  def sale_price
    0
  end

  def budget
    0
  end

  def budget_expended
    0
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
