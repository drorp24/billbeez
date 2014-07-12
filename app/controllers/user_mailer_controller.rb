class UserMailerController < ApplicationController

  def weekly()
#    @user = User.last
    render :file => 'user_mailer/weekly.html.erb', :layout => 'user_mailer'
  end

end