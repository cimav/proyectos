class ProjectTypesController < ApplicationController
  before_action :set_project_type, only: [:show, :edit, :update, :destroy, :reorder_status, :add_status, :statuses]

  # GET /project_types
  # GET /project_types.json
  def index
    @project_types = ProjectType.all
    first = @project_types.first
    if first 
      redirect_to controller: 'project_types', action: 'edit', id: first.id
    else
      redirect_to controller: 'project_types', action: 'new'
    end
  end

  # GET /project_types/1
  # GET /project_types/1.json
  def show
  end

  # GET /project_types/new
  def new
    @project_type = ProjectType.new
  end

  # GET /project_types/1/edit
  def edit
    @params_id = params[:id]
    @project_types = ProjectType.all
  end

  # POST /project_types
  # POST /project_types.json
  def create
    @project_type = ProjectType.new(project_type_params)

    respond_to do |format|
      if @project_type.save
        format.html { redirect_to project_types_path, notice: 'Tipo de proyecto creado.' }
        format.json { render :show, status: :created, location: @project_type }
      else
        format.html { render :new }
        format.json { render json: @project_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_types/1
  # PATCH/PUT /project_types/1.json
  def update
    respond_to do |format|
      if @project_type.update(project_type_params)
        format.html { redirect_to @project_type, notice: 'Project type was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_type }
      else
        format.html { render :edit }
        format.json { render json: @project_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_types/1
  # DELETE /project_types/1.json
  def destroy
    @project_type.destroy
    respond_to do |format|
      format.html { redirect_to project_types_url, notice: 'Project type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def statuses 
    render layout: false
  end


  def reorder_status
    i = 1
    params[:ps].each do |ps|
      pstatus = ProjectStatus.find(ps)
      pstatus.position = i
      pstatus.save
      i += 1
    end
    respond_to do |format|
      format.html do
        if request.xhr?
          json = {}
          json[:flash] = 'Reordenado'
          render :json => json
        else
          redirect_to @project_type
        end
      end
      format.json { render :show, status: :ok, flash: 'Reordenado',location: @project_type }
    end
  end

  def add_status
    next_pos = @project_type.project_statuses.maximum(:position).next rescue 1
    ps = @project_type.project_statuses.new
    ps.name = params[:new_status]
    ps.position = next_pos
    respond_to do |format|
      if ps.save
        format.html do
          if request.xhr?
            json = {}
            json[:new_status_id] = ps.id
            json[:flash] = 'Nuevo estado guardado'
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
            json[:errors] = ps.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @project_type
          end
        end
      end
    end
  end


  def update_status 
    ps = ProjectStatus.find(params[:psid])
    ps.name = params[:value]
    respond_to do |format|
      if ps.save
        format.html do
          if request.xhr?
            json = {}
            json[:psid] = ps.id
            json[:flash] = 'Estado actualizado'
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
            json[:errors] = ps.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @project_type
          end
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_type
      @project_type = ProjectType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_type_params
      params.require(:project_type).permit(:name)
    end
end
