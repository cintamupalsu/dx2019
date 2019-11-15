class ProgressesController < ApplicationController
  before_action :authenticate_user!

  def index
    @progress = Progress.where("report_id = ?", params[:id])
  end

  def new
  end

  def edit
  end
end
