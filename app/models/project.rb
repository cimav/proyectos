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
  has_many   :project_person
  has_many   :project_participants
  has_many   :people, :through => :project_person
  


  before_validation :set_extra, on: :create

  RESEARCH_BASIC   = 1
  RESEARCH_APPLIED = 2
  RESEARCH_TECH    = 3

  RESEARCH_TYPE = {
    RESEARCH_BASIC   => "Básica",
    RESEARCH_APPLIED => "Aplicada",
    RESEARCH_TECH    => "Desarrollo Tecnológico"
  }


  STATUS_REQ_TEXT = {
    -1 => 'Req. capturada',
     0 => 'En espera de autorizaci&oacute,n',
     1 => 'Requisicion autorizada',
     2 => 'Solicitud Cotizaci&oacute,n',
     3 => 'Cotizaciones Capturadas',
     4 => 'Pedido Generado',
     5 => 'Pedido Autorizado',
     6 => 'Pedido Parcialmente Surtido',
     7 => 'Pedido Surtido',
     8 => 'Cancelado(Se cometio un Error)',
     9 => 'Req. Capturada no autorizada',
    10 => 'Cancelada por presupuesto'
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

  def purchase_requests(limit = nil)
    sql = "SELECT DISTINCT 
             co01_requisicion AS requisicion, 
             co01_fecha_req AS fecha_req, 
             CONCAT(SUBSTRING(co01_fecha_req,7,2),'/',SUBSTRING(co01_fecha_req,5,2),'/',SUBSTRING(co01_fecha_req,1,4)) AS fecha, 
             co01_cve_responsable, 
             CONCAT(TRIM(r.no01_nombre),' ',TRIM(r.no01_apellido_pat),' ',TRIM(r.no01_apellido_mat)) AS responsable, 
             co01_usuario, 
             CONCAT(TRIM(u.no01_nombre),' ',TRIM(u.no01_apellido_pat),' ',TRIM(u.no01_apellido_mat)) AS usuario, 
             co01_solicitante, 
             CONCAT(TRIM(s.no01_nombre),' ',TRIM(s.no01_apellido_pat),' ',TRIM(s.no01_apellido_mat)) AS solicitante, 
             co01_status AS status
          FROM 
            netmultix.co01 
            LEFT JOIN netmultix.co02 on co01_requisicion = co02_requisicion 
            LEFT JOIN netmultix.no01 u on co01_usuario = u.no01_cve_emp 
            LEFT JOIN netmultix.no01 r on co01_cve_responsable = r.no01_cve_emp 
            LEFT JOIN netmultix.no01 s on co01_solicitante = s.no01_cve_emp 
          WHERE co02_proyecto LIKE '%#{self.erp_number}%'  
          ORDER BY co01_fecha_req DESC"

    if limit && limit > 0
      sql = sql + " LIMIT #{limit.to_i}"
    end

    connection = ActiveRecord::Base.connection
    result = connection.exec_query(sql)

    rows = []
    
    result.each do |row|
      row['estado'] = STATUS_REQ_TEXT[row['status'].to_i]
      rows << row
    end

    return rows
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
          netmultix.ct05
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

  def start_date
    d = self.schedules.where(schedule_type: Schedule::PROJECT_DURATION).first
    d.start_date rescue nil
  end

  def end_date
    d = self.schedules.where(schedule_type: Schedule::PROJECT_DURATION).first
    d.end_date rescue nil
  end


  private

    def set_extra
  	  self.department_id = self.manager.department_id
      self.name = self.internal_name

      first_status = self.project_type.project_statuses.where(position: 1).first
      self.status = first_status.id
    end

end
