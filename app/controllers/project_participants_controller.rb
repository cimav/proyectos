class ProjectParticipantsController < ApplicationController
  before_action :auth_required
  before_action :set_project_participant, only: [:show, :edit, :update, :destroy]
  

  # GET /project_participants
  # GET /project_participants.json
  def index
    @project_participants = ProjectParticipant.all
  end

  # GET /project_participants/1
  # GET /project_participants/1.json
  def show
  end

  # GET /project_participants/new
  def new
    @project_participant = ProjectParticipant.new
  end

  # GET /project_participants/1/edit
  def edit
  end

  # POST /project_participants
  # POST /project_participants.json
  def create
    @project_participant = ProjectParticipant.new(project_participant_params)

    respond_to do |format|
      if @project_participant.save
        url = url_for(action: 'people', controller: 'projects', id: @project_participant.project_id, project_participant_id: @project_participant.id )
        format.html { redirect_to url, notice: 'Participante agregado.' }
        format.json { render :show, status: :created, location: @project_participant }
      else
        format.html { render :new }
        format.json { render json: @project_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_participants/1
  # PATCH/PUT /project_participants/1.json
  def update
    respond_to do |format|
      if @project_participant.update(project_participant_params)
        format.html { redirect_to @project_participant, notice: 'Project folder was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_participant }
      else
        format.html { render :edit }
        format.json { render json: @project_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_participants/1
  # DELETE /project_participants/1.json
  def destroy
    @project_participant.destroy
    respond_to do |format|
      format.html { redirect_to project_participants_url, notice: 'Project folder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_participant
      @project_participant = ProjectParticipant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_participant_params
      params.require(:project_participant).permit(:role, :user_id, :project_id)
    end
end
