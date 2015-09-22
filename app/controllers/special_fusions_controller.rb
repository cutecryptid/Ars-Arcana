class SpecialFusionsController < ApplicationController
  autocomplete :persona, :name
  before_action :set_special_fusion, only: [:show, :edit, :update, :destroy]
  before_action :set_arcana_and_persona

  # GET /special_fusions
  # GET /special_fusions.json
  def index
    @special_fusions = SpecialFusion.all
  end

  # GET /special_fusions/1
  # GET /special_fusions/1.json
  def show
  end

  # GET /special_fusions/new
  def new
    @special_fusion = SpecialFusion.new
  end

  # GET /special_fusions/1/edit
  def edit
  end

  # POST /special_fusions
  # POST /special_fusions.json
  def create
    
    @special_fusion = @persona.special_fusions.build(special_fusion_params)

    respond_to do |format|
      if @special_fusion.save
        format.html { redirect_to arcana_persona_path(@arcana.slug, @persona.slug), notice: 'Special fusion was successfully created.' }
        format.json { render :show, status: :created, location: arcana_persona_path(@arcana.slug, @persona.slug) }
      else
        format.html { render :new }
        format.json { render json: @special_fusion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /special_fusions/1
  # PATCH/PUT /special_fusions/1.json
  def update
    respond_to do |format|
      if @special_fusion.update(special_fusion_params)
        format.html { redirect_to arcana_persona_path(@arcana.slug, @persona.slug), notice: 'Special fusion was successfully updated.' }
        format.json { render :show, status: :ok, location: arcana_persona_path(@arcana.slug, @persona.slug) }
      else
        format.html { render :edit }
        format.json { render json: @special_fusion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /special_fusions/1
  # DELETE /special_fusions/1.json
  def destroy
    @special_fusion.destroy
    respond_to do |format|
      format.html { redirect_to arcana_persona_path(@arcana.slug, @persona.slug), notice: 'Special fusion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_special_fusion
      @special_fusion = SpecialFusion.find(params[:id])
    end

    def set_arcana_and_persona
      @arcana = Arcana.friendly.find(params[:arcana_id])
      @persona = Persona.friendly.find(params[:persona_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def special_fusion_params
      ingredients = params[:special_fusion][:ingr].split(',').collect(&:strip)
      ingr_id = []
      ingredients.each do |ingr|
        per = Persona.find_by name: ingr
        ingr_id << per.id
      end
      params[:special_fusion][:ingr] = ingr_id.to_json
      params.require(:special_fusion).permit(:persona_id, :ingr)
    end
end
