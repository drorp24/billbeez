class VersionsController < ApplicationController
  before_action :set_version, only: [:show, :edit, :update, :destroy]
#  before_action :set_campaign, except: [:create, :show, :index, :edit]
  before_action :set_campaign, only: [:new]


  # GET /versions
  # GET /versions.json
  def index
    @versions = Version.all
  end

  # GET /versions/1
  # GET /versions/1.json
  def show
  end

  # GET /versions/new
  def new

    if session[:version_id]
      @version = Version.find(session[:version_id])
      return
    end

    last_version = Version.last
    if last_version.present?
      @version = @campaign.versions.build(last_version.attributes.except("id"))
    else
      @version = @campaign.versions.build
    end
    @version.save
    session[:version_id] = @version.id

  end

  # GET /versions/1/edit
  def edit
  end

  # POST /versions
  # POST /versions.json
  def create
    @version = Version.new(version_params)

    respond_to do |format|
      if @version.save
        format.html { redirect_to user_mailer_weekly_path, notice: 'Version was successfully created.' }
        format.json { render action: 'show', status: :created, location: @version }
      else
        format.html { render action: 'new' }
        format.json { render json: @version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /versions/1
  # PATCH/PUT /versions/1.json
  def update
    respond_to do |format|
      if @version.update(version_params)
        format.html { 
          if request.xhr? 
            render nothing: true
          else
            redirect_to versions_path
          end 
          }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /versions/1
  # DELETE /versions/1.json
  def destroy
    @version.destroy
    respond_to do |format|
      format.html { redirect_to versions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_version
      @version = Version.find(params[:id])
    end

    def set_campaign
      @campaign = Campaign.find(params[:campaign_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def version_params
      params.permit!.except(:action, :controller, :_method, :authenticity_token)
    end
end
