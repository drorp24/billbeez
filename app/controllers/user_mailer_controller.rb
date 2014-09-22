class UserMailerController < ApplicationController

  def weekly()   

    @newsletter = Newsletter.find(params[:newsletter_id]) 
    @version =    params[:version_id] ? Version.find(params[:version_id]) : @newsletter.version
    @section =    params[:section]
    @control =    params[:control]
    @edit =       params[:edit]
    
    render layout: request.xhr? ? "layouts/xhr_user_mailer" : "layouts/application"

  end
  
end