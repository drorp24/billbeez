class UserMailerController < ApplicationController

  def weekly()
    @version = Version.find(params[:version_id])
    @newsletter = Newsletter.find(params[:newsletter_id])  
    render layout: !request.xhr?
  end

end