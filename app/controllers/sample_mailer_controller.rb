class SampleMailerController < ApplicationController

  def weekly()
    @version = Version.find(params[:version_id])
    render layout: !request.xhr?
  end

end