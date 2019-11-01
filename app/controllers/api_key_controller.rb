class ApiKeyController < ApplicationController
  before_action :authenticate_user!

  def index
    @apis = Api.where("user_id = ? AND status != ?", current_user.id, 2)
  end

  def new
    key = SecureRandom.urlsafe_base64
    api = Api.new(key: key, user_id: current_user.id, status: 0)
    if api.save
      flash[:success] = "新規APIを追加しました。"
      redirect_to api_key_path
    end
  end

  def onoffinactivate
    action = params[:act].to_i
    apikey = params[:apikey]
    api = Api.where("key = ?",apikey).first
    api.update_attributes(status: action)
    redirect_to api_key_path
  end

end
