class ProjectsController < ApplicationController
  before_action :auth_required
  before_action :set_project, only: [:show, :edit, :update, :destroy, :messages, 
                                     :new_message, :show_message, :edit_message, 
                                     :schedules, :new_schedule, :show_schedule, 
                                     :edit_schedule, :files, :folder_files, 
                                     :folder_files_list, :folders, :budget, 
                                     :budget_details, :purchase_requests, 
                                     :show_purchase_request, :people, :services,
                                     :details, :update_status ]

  # GET /projects
  # GET /projects.json
  def index
    @p = params[:p]
    case @p 
    when 'responsable'
      @projects = Project.where("manager_id = ? AND status <> ? AND status <> ?", current_user.id, Project::STATUS_END, Project::STATUS_CANCELLED)
    when 'participo'
      @projects = Project.where("(manager_id = ? OR agent_id = ? OR ? IN (SELECT user_id FROM project_participants WHERE project_id = projects.id) ) AND (status <> ? AND status <> ?)", current_user.id, current_user.id, current_user.id, Project::STATUS_END, Project::STATUS_CANCELLED)
    when 'mis-proyectos'
      @projects = Project.where("manager_id = ? OR agent_id = ? OR ? IN (SELECT user_id FROM project_participants WHERE project_id = projects.id)", current_user.id, current_user.id, current_user.id)
    when 'administro'
      @projects = Project.where("agent_id = ? AND status <> ? AND status <> ?", current_user.id, Project::STATUS_END, Project::STATUS_CANCELLED)
    when 'activos'
      @projects = Project.all
    when 'todos'
      @projects = Project.all
    end 
    
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  def details
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    @project.agent_id = current_user.id
    @project.business_unit_id = current_user.business_unit_id

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Proyecto creado.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
  
        #UPDATE dates
        pd_res = @project.schedules.where(schedule_type: Schedule::PROJECT_DURATION)
        if pd_res.count == 1
          project_duration = pd_res.first
          project_duration.user_id = current_user.id
        else
          project_duration = @project.schedules.new
          project_duration.title = "Duración del proyecto"
          project_duration.content = ""
          project_duration.user_id = current_user.id
          project_duration.schedule_type = Schedule::PROJECT_DURATION
          project_duration.status = Schedule::ACTIVE
        end
        project_duration.start_date = params[:project_start_date]
        project_duration.end_date = params[:project_end_date]
        project_duration.save

        format.html { redirect_to details_project_url, notice: 'Proyecto actualizado.' }
        format.json { render :details, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    prev_status = @project.project_status.name

    @project.status = params[:new_status]

    respond_to do |format|
      if @project.save
        
        nm = @project.messages.new
        nm.user_id = current_user.id
        nm.title = "Proyecto #{@project.number} cambió a #{@project.project_status.name}"
        nm.content = "Proyecto #{@project.number} cambió de #{prev_status} a #{@project.project_status.name}.<br/>#{params['status_notes']}"
        nm.status = Message::ACTIVE
        nm.message_type = Message::TYPE_STATUS
        nm.save

        format.html { redirect_to details_project_url, notice: 'Estado actualizado.' }
        format.json { render :details, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Proyecto eliminado.' }
      format.json { head :no_content }
    end
  end

  def messages
    
  end

  def new_message
    @message = @project.messages.new
  end

  def show_message
    @message = @project.messages.find(params[:message_id])
  end

  def edit_message
    @message = @project.messages.find(params[:message_id])
  end  

  def schedules
  end

  def new_schedule
    @schedule = @project.schedules.new
  end

  def show_schedule
    @schedule = @project.schedules.find(params[:schedule_id])
  end

  def edit_schedule
    @schedule = @project.schedules.find(params[:schedule_id])
  end  

  def files
    # Redirect to first folder
    first = @project.project_folders.order(:name).first 
    redirect_to action: "folder_files", id: @project.id, project_folder_id: first.id
  end

  def folder_files
    @project_folder = @project.project_folders.find(params[:project_folder_id]) 
  end

  def folder_files_list
    @project_folder = @project.project_folders.find(params[:project_folder_id]) 
    render layout: false
  end

  def folders
    render layout: false
  end

  def add_folder
    folder = @project.project_folders.new
    folder.name = params[:new_folder]
    folder.user_id = 72
    respond_to do |format|
      if folder.save
        format.html do
          if request.xhr?
            json = {}
            json[:new_status_id] = folder.id
            json[:flash] = 'Nueva carpeta guardada'
            render :json => json
          else
            redirect_to @project_type
          end
        end
      else
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = 'Error al guardar'
            json[:errors] = folder.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @project_type
          end
        end
      end
    end
  end

  def budget

  end

  def budget_details

  end

  def purchase_requests 
  end

  def show_purchase_request
    sql = "SELECT 
             co01_requisicion AS requisicion, 
             concat(SUBSTRING(co01_fecha_req,7,2),'/',SUBSTRING(co01_fecha_req,5,2),'/',SUBSTRING(co01_fecha_req,1,4)) AS fecha, 
             co01_cve_responsable, 
             CONCAT(TRIM(r.no01_nombre),' ',TRIM(r.no01_apellido_pat),' ',TRIM(r.no01_apellido_mat)) AS responsable, 
             co01_usuario, 
             CONCAT(TRIM(u.no01_nombre),' ',TRIM(u.no01_apellido_pat),' ',TRIM(u.no01_apellido_mat)) AS usuario, 
             co01_solicitante, 
             CONCAT(TRIM(s.no01_nombre),' ',TRIM(s.no01_apellido_pat),' ',TRIM(s.no01_apellido_mat)) AS solicitante, 
             co01_status AS status, 
             co02_proyecto AS cproyecto, 
             pr10_desc_completa AS proyecto, 
             co02_sol_cotizacion AS cotizacion,
             co02_partida AS partida, 
             co02_descripcion AS descripcion, 
             co02_desc_larga AS desclarga, 
             co02_status AS status2, 
             pv01_nombre AS proveedor,
             co03_tiempo_entrega AS tiempoentrega,
             co09_cant_rec AS cantidad, 
             co09_costo AS costo, 
             co09_importe_ped AS importe, 
             co09_importe_iva AS iva, 
             co09_impuesto AS impuesto, 
             co18_desc_sesion AS sesion, 
             co05_pedido AS ordencompra, 
             CONCAT(SUBSTRING(co05_fecha_pedido,7,2),'/',SUBSTRING(co05_fecha_pedido,5,2),'/',SUBSTRING(co05_fecha_pedido,1,4)) AS fechaordencompra,
             CONCAT(SUBSTRING(co02_fecha_sesion,7,2),'/',SUBSTRING(co02_fecha_sesion,5,2),'/',SUBSTRING(co02_fecha_sesion,1,4)) AS fechasesion 
           FROM 
             netmultix.co01 
             INNER JOIN netmultix.co02 on co01_requisicion = co02_requisicion 
             LEFT JOIN netmultix.co09 on co01_requisicion = co09_requisicion and co02_id = co09_id 
             LEFT JOIN netmultix.co05 on co05_sol_cotizacion = co02_sol_cotizacion 
             LEFT JOIN netmultix.co03 on co03_sol_cotizacion = co02_sol_cotizacion and co03_cve_prov = co05_cve_prov 
             LEFT JOIN netmultix.pv01 on co03_cve_prov = pv01_clave 
             LEFT JOIN netmultix.pr10 on co02_proyecto = pr10_proyecto 
             LEFT JOIN netmultix.co18 on co02_sesion = co18_id_sesion 
             LEFT JOIN netmultix.no01 u on co01_usuario = u.no01_cve_emp 
             LEFT JOIN netmultix.no01 r on co01_cve_responsable = r.no01_cve_emp 
             LEFT JOIN netmultix.no01 s on co01_solicitante = s.no01_cve_emp 
          WHERE CO01_REQUISICION = '#{params[:req_id]}'"

    @request = {} 
    connection = ActiveRecord::Base.connection
    result = connection.exec_query(sql)


    @request['number'] = params[:req_id]
    @request['details'] = []
    
    result.each do |row|
      row['estado'] = Project::STATUS_REQ_TEXT[row['status'].to_i]
      @request['details'] << row
    end

    sql_comments = "SELECT * FROM netmultix.pr07h WHERE pr07h_folio = '#{params[:req_id]}'"
    @request['comments'] = []
    result = connection.exec_query(sql_comments)
    result.each do |row|
      @request['comments'] << row
    end


  end

  def people

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :client_id, :number, :internal_name, :goal, :manager_id, :agent_id, :department_id, :business_unit_id, :project_type_id, :status, :research_type, :erp_number, :results, :new_status, :status_notes)
    end
end
