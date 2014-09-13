class HomeController < ApplicationController
before_action :authenticate_user!

  def index
    redirect_to campaigns_path
  end
end
