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


end
