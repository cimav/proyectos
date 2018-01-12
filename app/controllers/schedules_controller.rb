class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user_id = current_user.id
    @schedule.status = Schedule::ACTIVE
    @schedule.schedule_type = Schedule::DATE
    @project = @schedule.project

    if (params[:all_day]) 
      start_date = params[:start_date_date].to_s +  ' 00:00:00'
      end_date = params[:end_date_date].to_s +  ' 00:00:00'
    else
      start_date = params[:start_date_date].to_s +  ' ' + params['start_date_hours']
      end_date = params[:end_date_date].to_s +  ' ' + params['end_date_hours']
    end

    @schedule.start_date = start_date
    @schedule.end_date = end_date

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to schedules_project_url(@project), notice: 'Evento agregado.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render "projects/new_schedule", schedule: @schedule, project: @project, notice: 'No se pudo agregar.'}
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    @project = @schedule.project

    if (params[:all_day]) 
      start_date = params[:start_date_date].to_s +  ' 00:00:00'
      end_date = params[:end_date_date].to_s +  ' 00:00:00'
    else
      start_date = params[:start_date_date].to_s +  ' ' + params['start_date_hours']
      end_date = params[:end_date_date].to_s +  ' ' + params['end_date_hours']
    end

    @schedule.start_date = start_date
    @schedule.end_date = end_date
    
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to schedules_project_url(@project), notice: 'Evento actualizado.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render "projects/edit_schedule", schedule: @schedule, project: @project, notice: 'No se pudo actualizar.'}
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      puts params
      params.require(:schedule).permit(:title, :content, :project_id, :all_day, :start_date_date, :start_date_hours, :end_date_date, :end_date_hours, :schedule_type, :user_id)
    end
end
