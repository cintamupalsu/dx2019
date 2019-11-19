class LandingPagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to map_path
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def uploadimage
    lat = params[:lat].to_f
    lon = params[:lon].to_f
    key = params[:key]
    vessel_id = params[:id].to_i
    api = Api.where("key = ?", key).first
    if api != nil
      @jsonstring = proceedImage(vessel_id,lat ,lon)
      metaresult = {responseInfo: {status: 200, developerMessage: "OK"}}
    else
      metaresult = {responseInfo: {status: 100, developerMessage: "User not found"}}
      render :json=> {metadata: metaresult}
      return
    end
    render :json=> {metadata: metaresult, lat: lat, lon: lon, user: api.user.username, jsonstring: @jsonstring}
  end

  private

  def proceedImage(vessel_id, lat, lon)
    vessel = Vessel.find(vessel_id)
    operation = Operation.where("vessel_id = ? AND kind = ?", vessel_id, 1).first

    apikey = Rails.application.secrets.watson_visual_recognition_api_key
    authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
      apikey: apikey
    )
    visual_recognition = IBMWatson::VisualRecognitionV3.new(
      version: "2018-03-19",
      authenticator: authenticator
    )
    kotoba_match = false
    result = ""
    open(operation.address) do |img|
      File.open("./public/temp/t.jpg","wb") do |file|
        file.write(img.read)
      end
    end
    report = Report.create(lat: lat, lon: lon, content: "Object found", vessel_id: vessel_id)


    File.open("./public/temp/t.jpg") do |file|
        classes = visual_recognition.classify(
          images_file: file,
          threshold: "0.6",
          classifier_ids: ["default"]
        )
        report.image.attach(io: File.open(file.path),filename: 't.jpg')
        result = classes.result["images"][0]["classifiers"][0]["classes"]
        report.json = result.to_s
        if report.save
          ActionCable.server.broadcast 'room_channel', content: report.content,lat: report.lat, lon: report.lon, jsonstring: report.json, picture: rails_blob_path(report.image, disposition: "attachment", only_path: true)
        end
    end
    return result
  end

end
