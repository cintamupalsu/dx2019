class MainMapController < ApplicationController
  before_action :authenticate_user!

  def map
    @vessels = Vessel.all
    @reports = Report.all
  end

  def report
    @vessel = Vessel.find(params[:id])
    @reports = @vessel.reports.paginate(page: params[:page])
    @report = @vessel.reports.build
  end

end
