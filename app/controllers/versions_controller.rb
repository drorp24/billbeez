class VersionsController < ApplicationController
  before_action :set_version, only: [:approve, :show, :edit, :update, :destroy]
#  before_action :set_campaign, except: [:create, :show, :index, :edit]

  def approve
    @version.update(user_id: current_user.id, approved_at: Time.now)
    session[:campaign_id] = @campaign.id
    redirect_to campaign_versions_path(@campaign)
  end

  # GET /versions
  # GET /versions.json
  def index
    @versions = @campaign.versions
  end

  # GET /versions/1
  # GET /versions/1.json
  def show
  end

  # GET /versions/new
  def new

    last_version = @campaign.versions.last || Version.last
    if last_version.present?
      @version = @campaign.versions.build(last_version.attributes.except("id"))
    else
      @version = @campaign.versions.build
    end
    @version.locale_id = 1 unless @version.locale_id
    @version.save
    session[:version_id] = @version.id
    @customer = @customer_id = session[:customer_id] = nil
    @newsletter = @newsletter_id = session[:newsletter_id] = nil

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
      session[:version_id] = @version.id if @version
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def version_params
      params.permit!.except(:action, :controller, :_method, :authenticity_token)
    end
end
