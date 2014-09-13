class UserMailerController < ApplicationController

  def weekly()   #ToDo: don't pass version_id parameter
    @newsletter = Newsletter.find(params[:newsletter_id]) 
    @version = @newsletter.version 
    @section = params[:section]
    @control = params[:control]
    render layout: !request.xhr?
  end
  
end