class ApplicationController < ActionController::Base
before_filter :authenticate_user!
before_filter :find_session, :except => [:destroy]

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def find_session    
    @campaign_id = session[:campaign_id] = params[:campaign_id] || session[:campaign_id]
    @campaign = Campaign.find(@campaign_id) if @campaign_id
    @version_id = session[:version_id] = params[:version_id] || session[:version_id]
    @version = Version.find(@version_id) if @version_id
    @customer_id = session[:customer_id] = params[:customer_id] || session[:customer_id]
    @customer = Customer.find(@customer_id) if @customer_id
    @newsletter_id = session[:newsletter_id] = params[:newsletter_id] || session[:newsletter_id] 
    @newsletter = Newsletter.find(@newsletter_id) if @newsletter_id     
  end

end
