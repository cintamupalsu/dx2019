class ReportsController < ApplicationController
  before_action :authenticate_user!

  def create
    vessel = Vessel.find(report_params['vessel_id'])
    @report = vessel.reports.build(report_params)
    @report.image.attach(params[:report][:image])
    if @report.save
      flash[:success] = "Report created!"
    end
    redirect_to report_path(:id => vessel.id)
  end

  def destroy # unused
    vessel = Vessel.find(@report.vessel_id)
    @report.destroy
    flash[:success] = "Report deleted"
    redirect_to report_path(:id => vessel.id)
  end

  def hapus
    report = Report.find(params[:id])
    vessel = Vessel.find(report.vessel_id)
    report.destroy
    flash[:success] = "Report deleted"
    redirect_to report_path(:id => vessel.id)
  end

  private

  def report_params
    params.require(:report).permit(:lat, :lon, :vessel_id, :content, :image)
  end
end
