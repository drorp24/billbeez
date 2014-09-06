class ApplicationController < ActionController::Base
before_filter :authenticate_user!
before_filter :find_context   #, :except => [:destroy] # this except was there originally, dont know why
before_filter :change_context #, :except => [:destroy]

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def clear_campaign
    @version_id = session[:version_id] = 
    @customer_id = session[:customer_id] = 
    @newsletter_id = session[:newsletter_id] = nil
  end

  def change_context
    clear_campaign if params[:campaign_id]  != session[:campaign_id]
  end

  def find_context  
    puts ""
    puts ""
    puts "BEFORE"  
    puts ""
    puts "session[:customer_id] = " + session[:customer_id].to_s
    puts ""
    puts "params[:customer_id] = " + params[:customer_id].to_s
    puts ""
    puts ""  
    puts "session[:newsletter_id] = " + session[:newsletter_id].to_s
    puts ""
    puts "params[:newsletter_id] = " + params[:newsletter_id].to_s
    puts ""
    puts ""  
    puts "session[:bill_id] = " + session[:bill_id].to_s
    puts ""
    puts "params[:bill_id] = " + params[:bill_id].to_s
    puts ""
    puts ""  
    @campaign_id = session[:campaign_id] = params[:campaign_id] || session[:campaign_id]
    @campaign = Campaign.find(@campaign_id) if @campaign_id
    @version_id = session[:version_id] = params[:version_id] || session[:version_id]
    @version = Version.find(@version_id) if @version_id
    @customer_id = session[:customer_id] = params[:customer_id] || session[:customer_id]
    @customer = Customer.find(@customer_id) if @customer_id
    @newsletter_id = session[:newsletter_id] = params[:newsletter_id] || session[:newsletter_id] 
    @newsletter = Newsletter.find(@newsletter_id) if @newsletter_id 
    if params[:due_id]
      @due_id = session[:due_id] = params[:due_id] 
      @due = Due.find(@due_id)
    end
     if params[:notification_id]
      @notification_id = session[:notification_id] = params[:notification_id] 
      @notification = Notification.find(@notification_id)
    end   
    if params[:line_id]
      @line_id = session[:line_id] = params[:line_id] 
      @line = Line.find(@line_id)
    end
    if params[:plan_id]
      @plan_id = session[:plan_id] = params[:plan_id] 
      @plan = Plan.find(@plan_id)
    end
    puts ""
    puts "AFTER:"  
    puts ""
    puts ""  
    puts "@customer.id = " + @customer.id.to_s if @customer
    puts ""
    puts "@newsletter.id = " + @newsletter.id.to_s if @newsletter
    puts ""
    
  end

end
