class KotobasController < ApplicationController
  before_action :set_kotoba, only: [:show, :edit, :update, :destroy]

  # GET /kotobas
  # GET /kotobas.json
  def index
    @kotobas = Kotoba.all
  end

  # GET /kotobas/1
  # GET /kotobas/1.json
  def show
  end

  # GET /kotobas/new
  def new
    @kotoba = Kotoba.new
  end

  # GET /kotobas/1/edit
  def edit
  end

  # POST /kotobas
  # POST /kotobas.json
  def create
    @kotoba = Kotoba.new(kotoba_params)

    respond_to do |format|
      if @kotoba.save
        format.html { redirect_to @kotoba, notice: 'Kotoba was successfully created.' }
        format.json { render :show, status: :created, location: @kotoba }
      else
        format.html { render :new }
        format.json { render json: @kotoba.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kotobas/1
  # PATCH/PUT /kotobas/1.json
  def update
    respond_to do |format|
      if @kotoba.update(kotoba_params)
        format.html { redirect_to @kotoba, notice: 'Kotoba was successfully updated.' }
        format.json { render :show, status: :ok, location: @kotoba }
      else
        format.html { render :edit }
        format.json { render json: @kotoba.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kotobas/1
  # DELETE /kotobas/1.json
  def destroy
    @kotoba.destroy
    respond_to do |format|
      format.html { redirect_to kotobas_url, notice: 'Kotoba was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kotoba
      @kotoba = Kotoba.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kotoba_params
      params.require(:kotoba).permit(:word, :message)
    end
end
