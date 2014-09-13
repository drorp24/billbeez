class VersionsController < ApplicationController
  before_action :set_version, only: [:approve, :unapprove, :show, :edit, :update, :destroy]
#  before_action :set_campaign, except: [:create, :show, :index, :edit]

  def approve
    @version.update(user_id: current_user.id, approved_at: Time.now)
    session[:campaign_id] = @campaign.id
    redirect_to campaign_versions_path(@campaign), notice: "Version was successfully approved"
  end

  def unapprove
    @version.update(user_id: nil, approved_at: nil)
    session[:campaign_id] = @campaign.id
    redirect_to campaign_versions_path(@campaign), notice: "Version has returned to Draft mode"
  end

  # GET /versions
  # GET /versions.json
  def index

    if @campaign
      @versions = @campaign.versions
      @available_locales = Locale.pluck(:id) - @campaign.versions.pluck(:locale_id)
    else
      @versions = Version.all
      @available_locales = Locale.pluck(:id)
    end

  end

  # GET /versions/1
  # GET /versions/1.json
  def show
  end

  # GET /versions/new
  def new

    redirect_to root_path, notice: "Campaign should be selected first" unless @campaign
    @version = @campaign.versions.build

    @available_locales = Locale.pluck(:id) - @campaign.versions.pluck(:locale_id)
    redirect_to root_path, notice: "Versions for all locales created already" unless @available_locales.count > 0 # should never happen: "New" button should be disabled
    @available_locales_collection = @available_locales.map{|locale_id| [Locale.find(locale_id).description, locale_id]}    

  end

  # GET /versions/1/edit
  def edit
    @version = Version.find(params[:id])
    render nothing: request.xhr?
  end

  # POST /versions
  # POST /versions.json
  def create

    if Version.where(locale_id: version_params[:locale_id]).any?
      @version = Version.where(locale_id: version_params[:locale_id]).last.dup
      @version.update(version_params)
      @version.campaign_id = @campaign.id
    else
      @version = @campaign.versions.build(version_params)
    end

    respond_to do |format|
      if @version.save
        format.html { redirect_to edit_campaign_version_path(@campaign, @version), notice: 'Version was successfully created.' }
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
            redirect_to edit_campaign_version_path(@campaign, @version)
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
      params[:version].permit!
    end
end
