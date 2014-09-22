class ApplicationController < ActionController::Base
before_filter :authenticate_user!
before_filter :find_context   #, :except => [:destroy] # this except was there originally, dont know why
before_filter :change_context #, :except => [:destroy]

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_campaign
    @current_campaign
  end

  def image_url(source)
    return "#{root_url}#{ActionController::Base.helpers.asset_path("missing-48.png")}" unless source
    "#{root_url}#{ActionController::Base.helpers.asset_path(source)}"
  end

  def clear_campaign
    @version_id = session[:version_id] = 
    @customer_id = session[:customer_id] = 
    @newsletter_id = session[:newsletter_id] = nil
  end

  def change_context
    if params[:campaign_id] and (params[:campaign_id]  != session[:campaign_id])
      session[:campaign_id] = params[:campaign_id]
      @current_campaign = Campaign.find(session[:campaign_id])
    end 
    
  end

  def find_context
    if session[:campaign_id]
      @current_campaign = Campaign.find(session[:campaign_id])
    elsif params[:campaign_id]
      session[:campaign_id] = params[:campaign_id]
      @current_campaign = Campaign.find(session[:campaign_id])
    else
      @current_campaign = Campaign.last
      session[:campaign_id] = @current_campaign.id
    end
    @newsletter_edit = true if ["bills", "dues", "reminders", "notifications", "plans", "charges", "features", "lines"].include? params[:controller]  
    @campaign_id = params[:campaign_id] 
    @campaign = Campaign.find(@campaign_id) if @campaign_id
    @version_id = params[:version_id] 
    @version = Version.find(@version_id) if @version_id
    @customer_id = params[:customer_id] 
    @customer = Customer.find(@customer_id) if @customer_id
    @newsletter_id = params[:newsletter_id] 
    @newsletter = Newsletter.find(@newsletter_id) if @newsletter_id 
    @customer = @newsletter.customer if @newsletter
    if params[:due_id]
      @due_id = params[:due_id] 
      @due = Due.find(@due_id)
    end
     if params[:notification_id]
      @notification_id = params[:notification_id] 
      @notification = Notification.find(@notification_id)
    end   
    if params[:line_id]
      @line_id = params[:line_id] 
      @line = Line.find(@line_id)
    end
    if params[:plan_id]
      @plan_id = params[:plan_id] 
      @plan = Plan.find(@plan_id)
    end
  end

end
