class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reports = Report.all
  end

  def create
    # IBM Watson Initialization
    apikey = Rails.application.secrets.watson_visual_recognition_api_key
    authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
      apikey: apikey
    )
    visual_recognition = IBMWatson::VisualRecognitionV3.new(
      version: "2018-03-19",
      authenticator: authenticator
    )
    # End Initialization

    vessel = Vessel.find(report_params['vessel_id'])
    @report = vessel.reports.build(report_params)
    @report.image.attach(params[:report][:image])

    # Image file processing
    if report_params['image'] != nil
      file = report_params['image']
      File.open(file.path) do |images_file|
        classes = visual_recognition.classify(
          images_file: images_file,
          threshold: "0.6",
          classifier_ids: ["default"]
        )
        @report.json = classes.result["images"][0]["classifiers"][0]["classes"]
      end
    end

    if @report.save
      ActionCable.server.broadcast 'room_channel', content: @report.content,lat: @report.lat, lon: @report.lon, json: @report.json, picture: rails_blob_path(@report.image, disposition: "attachment", only_path: true)
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
