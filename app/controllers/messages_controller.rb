class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.status = Message::ACTIVE
    @project = @message.project
    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_project_url(@project), notice: 'Mensaje publicado.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render "projects/new_message", message: @message, project: @project, notice: 'No se pudo publicar.'}
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    @project = @message.project
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to messages_project_url(@project), notice: 'Mensaje actualizado.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render "projects/edit_message", message: @message, project: @project, notice: 'No se pudo actualizar.'}
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:title, :content, :project_id, :user_id)
    end
end
