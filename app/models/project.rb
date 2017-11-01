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
  has_many   :project_folders
  has_many   :project_files, :through => :project_folders
  


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

  def budget_resume
    resume = {}
    resume['autorizado'] = 0
    resume['disponible'] = 0
    self.budget_details.each do |row|
      resume['autorizado'] += row['total_autorizado']
      resume['disponible'] += row['total_disponible']
    end
    return resume
  end
  
  def end_schedule
    schedules.where(schedule_type: Schedule::PROJECT_END).first 
  end


  def budget_details
    sql = "SELECT 
        ct05_partida AS partida, 
        pr20_desc AS concepto,
        SUM(Autorizado) AS total_autorizado, 
        SUM(Pagado) AS total_pagado,
        SUM(Devengado) AS total_ejercido,
        SUM(Col2) AS total_col2,
        SUM(PorComprobar) AS total_por_comprobar, 
        SUM(Comprometido) AS total_comprometido,
        SUM(Autorizado) - SUM(Pagado) - SUM(Devengado) - SUM(Comprometido) AS total_disponible
      FROM (
        SELECT ct05_partida, 
          IF(pr12_columna = 1, SUM(ct05_hab_det-ct05_deb_det),0) AS Autorizado, 
          IF(pr12_columna = 4, SUM(ct05_deb_det-ct05_hab_det),0) AS Pagado, 
          IF(pr12_columna = 3, SUM(ct05_deb_det-ct05_hab_det),0) AS Devengado, 
          IF(pr12_columna = 2, SUM(ct05_deb_det-ct05_hab_det),0) AS Col2, 
          IF(pr12_columna = 6, SUM(ct05_deb_det-ct05_hab_det),0) AS PorComprobar,
          IF(pr12_columna = 5, SUM(ct05_deb_det-ct05_hab_det),0) AS Comprometido 
        FROM 
          netmultix.ct05_2017 
          LEFT JOIN netmultix.pr12 ON TRIM(ct05_cta_det) LIKE CONCAT(TRIM(pr12_pre_ini),'%') 
        WHERE 
          ct05_proyecto LIKE '#{self.erp_number}%' 
          AND pr12_columna IN (1,2,3,4,5,6) 
        GROUP BY ct05_partida, pr12_columna 
        ORDER BY ct05_partida
      ) subtabla
      LEFT JOIN netmultix.pr20 ON ct05_partida = pr20_partida
      GROUP BY ct05_partida, pr20_desc"

    connection = ActiveRecord::Base.connection
    result = connection.exec_query(sql)

    rows = []
    
    result.each do |row| 
      if row['total_col2'] == row['total_disponible'] 
        row['total_devengado'] = 0.0 
      else
        row['total_devengado'] = row['total_col2'].abs + row['total_disponible']
        row['total_disponible'] = row['total_col2']
      end
      rows << row
    end

    return rows
  end


  private

    def set_extra
  	  self.department_id = self.manager.department_id
      self.name = self.internal_name

      first_status = self.project_type.project_statuses.where(position: 1).first
      self.status = first_status.id
    end

end
