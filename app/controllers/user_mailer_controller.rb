class UserMailerController < ApplicationController

  def weekly()
    render layout: !request.xhr?
  end

end