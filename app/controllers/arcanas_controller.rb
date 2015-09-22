class ArcanasController < ApplicationController
  before_action :set_arcana, only: [:show, :edit, :update, :destroy]
  before_action :set_arcana_personas, only: [:show]

  # GET /arcanas
  # GET /arcanas.json
  def index
    @arcanas = Arcana.all.order(:IntNumber)
  end

  # GET /arcanas/1
  # GET /arcanas/1.json
  def show
    @personas = @personas.order(:base_level)
  end

  # GET /arcanas/new
  def new
    @arcana = Arcana.new
  end

  # GET /arcanas/1/edit
  def edit
  end

  # POST /arcanas
  # POST /arcanas.json
  def create
    @arcana = Arcana.new(arcana_params)

    respond_to do |format|
      if @arcana.save
        format.html { redirect_to @arcana, notice: 'Arcana was successfully created.' }
        format.json { render :show, status: :created, location: @arcana }
      else
        format.html { render :new }
        format.json { render json: @arcana.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /arcanas/1
  # PATCH/PUT /arcanas/1.json
  def update
    respond_to do |format|
      if @arcana.update(arcana_params)
        format.html { redirect_to @arcana, notice: 'Arcana was successfully updated.' }
        format.json { render :show, status: :ok, location: @arcana }
      else
        format.html { render :edit }
        format.json { render json: @arcana.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /arcanas/1
  # DELETE /arcanas/1.json
  def destroy
    @arcana.destroy
    respond_to do |format|
      format.html { redirect_to arcanas_url, notice: 'Arcana was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_arcana
      @arcana = Arcana.friendly.find(params[:id])
    end

    def set_arcana_personas
      @personas = @arcana.personas
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def arcana_params
      params.require(:arcana).permit(:number, :name)
    end
end
