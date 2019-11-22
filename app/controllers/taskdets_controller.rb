class TaskdetsController < ApplicationController
  before_action :set_taskdet, only: [:show, :edit, :update, :destroy]

  # GET /taskdets
  # GET /taskdets.json
  def index
    @taskdets = Taskdet.all
  end

  # GET /taskdets/1
  # GET /taskdets/1.json
  def show
  end

  # GET /taskdets/new
  def new
    @taskdet = Taskdet.new
    @report_id = params[:report_id].to_i
  end

  # GET /taskdets/1/edit
  def edit
  end

  # POST /taskdets
  # POST /taskdets.json
  def create
    @taskdet = Taskdet.new(taskdet_params)

    respond_to do |format|
      if @taskdet.save
        format.html { redirect_to @taskdet, notice: 'Taskdet was successfully created.' }
        format.json { render :show, status: :created, location: @taskdet }
      else
        format.html { render :new }
        format.json { render json: @taskdet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /taskdets/1
  # PATCH/PUT /taskdets/1.json
  def update
    respond_to do |format|
      if @taskdet.update(taskdet_params)
        format.html { redirect_to @taskdet, notice: 'Taskdet was successfully updated.' }
        format.json { render :show, status: :ok, location: @taskdet }
      else
        format.html { render :edit }
        format.json { render json: @taskdet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taskdets/1
  # DELETE /taskdets/1.json
  def destroy
    @taskdet.destroy
    respond_to do |format|
      format.html { redirect_to taskdets_url, notice: 'Taskdet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_taskdet
      @taskdet = Taskdet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def taskdet_params
      params.require(:taskdet).permit(:content, :status, :user_id, :report_id)
    end
end
