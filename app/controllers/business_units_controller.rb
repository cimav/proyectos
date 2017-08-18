class BusinessUnitsController < ApplicationController
  before_action :set_business_unit, only: [:show, :edit, :update, :destroy]

  # GET /business_units
  # GET /business_units.json
  def index
    @business_units = BusinessUnit.all
  end

  # GET /business_units/1
  # GET /business_units/1.json
  def show
  end

  # GET /business_units/new
  def new
    @business_unit = BusinessUnit.new
  end

  # GET /business_units/1/edit
  def edit
  end

  # POST /business_units
  # POST /business_units.json
  def create
    @business_unit = BusinessUnit.new(business_unit_params)

    respond_to do |format|
      if @business_unit.save
        format.html { redirect_to @business_unit, notice: 'Business unit was successfully created.' }
        format.json { render :show, status: :created, location: @business_unit }
      else
        format.html { render :new }
        format.json { render json: @business_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business_units/1
  # PATCH/PUT /business_units/1.json
  def update
    respond_to do |format|
      if @business_unit.update(business_unit_params)
        format.html { redirect_to @business_unit, notice: 'Business unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @business_unit }
      else
        format.html { render :edit }
        format.json { render json: @business_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_units/1
  # DELETE /business_units/1.json
  def destroy
    @business_unit.destroy
    respond_to do |format|
      format.html { redirect_to business_units_url, notice: 'Business unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business_unit
      @business_unit = BusinessUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_unit_params
      params.require(:business_unit).permit(:name)
    end
end
