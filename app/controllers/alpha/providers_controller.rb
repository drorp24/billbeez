class Alpha::ProvidersController < ApplicationController
  before_action :set_alpha_provider, only: [:show, :edit, :update, :destroy]

  # GET /alpha/providers
  # GET /alpha/providers.json
  def index
    @alpha_providers = Alpha::Provider.all
    flash[:notice] = "Click Edit if you want to see the full list of fields"
  end

  # GET /alpha/providers/1
  # GET /alpha/providers/1.json
  def show
  end

  # GET /alpha/providers/new
  def new
    @alpha_provider = Alpha::Provider.new
  end

  # GET /alpha/providers/1/edit
  def edit
  end

  # POST /alpha/providers
  # POST /alpha/providers.json
  def create
    @alpha_provider = Alpha::Provider.new(alpha_provider_params)

    respond_to do |format|
      if @alpha_provider.save
        format.html { redirect_to alpha_providers_path, notice: 'Provider was successfully created.' }
        format.json { render action: 'show', status: :created, location: @alpha_provider }
      else
        format.html { render action: 'new' }
        format.json { render json: @alpha_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alpha/providers/1
  # PATCH/PUT /alpha/providers/1.json
  def update
    respond_to do |format|
      if @alpha_provider.update(alpha_provider_params)
        format.html { redirect_to alpha_providers_path, notice: 'Provider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @alpha_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alpha/providers/1
  # DELETE /alpha/providers/1.json
  def destroy
    @alpha_provider.destroy
    respond_to do |format|
      format.html { redirect_to alpha_providers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alpha_provider
      @alpha_provider = Alpha::Provider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alpha_provider_params
      params.require(:alpha_provider).permit!
    end
end
