class UserMailerController < ApplicationController

  def weekly()
    render :file => 'user_mailer/weekly.html.erb', :layout => 'user_mailer'
  end

end