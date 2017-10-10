class ProjectFoldersController < ApplicationController
  before_action :auth_required
  before_action :set_project_folder, only: [:show, :edit, :update, :destroy]
  

  # GET /project_folders
  # GET /project_folders.json
  def index
    @project_folders = ProjectFolder.all
  end

  # GET /project_folders/1
  # GET /project_folders/1.json
  def show
  end

  # GET /project_folders/new
  def new
    @project_folder = ProjectFolder.new
  end

  # GET /project_folders/1/edit
  def edit
  end


  def add_folder
    folder = ProjectFolder.new
    folder.project_id = params[:project_id]
    folder.name = params[:new_folder]
    folder.user_id = params[:user_id]
    respond_to do |format|
      if folder.save
        format.html do
          if request.xhr?
            json = {}
            json[:new_folder_id] = folder.id
            json[:flash] = 'Nueva carpeta creada'
            render :json => json
          else
            redirect_to folder
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
            redirect_to folder
          end
        end
      end
    end
  end

  # POST /project_folders
  # POST /project_folders.json
  def create
    @project_folder = ProjectFolder.new(project_folder_params)
    @project_folder.user_id = current_user.id

    respond_to do |format|
      if @project_folder.save
        url = url_for(action: 'folder_files', controller: 'projects', id: @project_folder.project_id, project_folder_id: @project_folder.id )
        format.html { redirect_to url, notice: 'Carpeta creada.' }
        format.json { render :show, status: :created, location: @project_folder }
      else
        format.html { render :new }
        format.json { render json: @project_folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_folders/1
  # PATCH/PUT /project_folders/1.json
  def update
    respond_to do |format|
      if @project_folder.update(project_folder_params)
        format.html { redirect_to @project_folder, notice: 'Project folder was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_folder }
      else
        format.html { render :edit }
        format.json { render json: @project_folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_folders/1
  # DELETE /project_folders/1.json
  def destroy
    @project_folder.destroy
    respond_to do |format|
      format.html { redirect_to project_folders_url, notice: 'Project folder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_folder
      @project_folder = ProjectFolder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_folder_params
      params.require(:project_folder).permit(:name, :description, :folder_type, :user_id, :project_id)
    end
end
