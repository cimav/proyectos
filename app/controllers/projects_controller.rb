class ProjectsController < ApplicationController
  before_action :auth_required
  before_action :set_project, only: [:show, :edit, :update, :destroy, :messages, :new_message, :show_message, :edit_message, :schedules, :new_schedule, :show_schedule, :edit_schedule]

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
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
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
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
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
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
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
