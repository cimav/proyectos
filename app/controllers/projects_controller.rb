class ProjectsController < ApplicationController
  before_action :auth_required
  before_action :set_project, only: [:show, :edit, :update, :destroy, :messages, 
                                     :new_message, :show_message, :edit_message, 
                                     :schedules, :new_schedule, :show_schedule, 
                                     :edit_schedule, :files, :folder_files, 
                                     :folder_files_list, :folders, :budget, :people,
                                     :services]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
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
        format.html { redirect_to @project, notice: 'Proyecto actualizado.' }
        format.json { render :show, status: :ok, location: @project }
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

  def people

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :client_id, :number, :internal_name, :goal, :manager_id, :agent_id, :department_id, :business_unit_id, :project_type_id, :status, :research_type, :erp_number, :results)
    end
end
