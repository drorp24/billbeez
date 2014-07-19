class UserMailerController < ApplicationController

  def weekly()
    @version = params[:version_id] ? Version.find(params[:version_id]) : Version.last  
    render layout: !request.xhr?
  end

end