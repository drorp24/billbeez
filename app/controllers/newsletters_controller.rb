class NewslettersController < ApplicationController
  before_action :set_newsletter, only: [:deliver, :show, :edit, :update, :destroy]

  def deliver
    UserMailer.weekly(@newsletter).deliver
    @newsletter.customer.update(last_newsletter: Time.now)
    redirect_to customers_path(campaign_id: params[:campaign_id], version_id: params[:version_id], locale_id: params[:locale_id])
  end


  # GET /newsletters
  # GET /newsletters.json
  def index
    if params[:customer_id]
      @newsletters = Newsletter.where(customer_id: params[:customer_id])
    elsif params[:version_id]
      @newsletters = Newsletter.where(version_id: params[:version_id])
    else
      @newsletters = Newsletter.all
    end
  end

  # GET /newsletters/1
  # GET /newsletters/1.json
  def show
  end

  # GET /newsletters/new
  def new

    # session to avoid creating another newsletter with every refresh
    @customer = Customer.find(params[:customer_id])
    @newsletter = @customer.newsletters.create(version_id: params[:version_id])

  end

  # GET /newsletters/1/edit
  def edit
  end

  # POST /newsletters
  # POST /newsletters.json
  def create
    @newsletter = Newsletter.new(newsletter_params)

    respond_to do |format|
      if @newsletter.save
        format.html { redirect_to newsletters_path, notice: 'Newsletter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @newsletter }
      else
        format.html { render action: 'new' }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /newsletters/1
  # PATCH/PUT /newsletters/1.json
  def update
    respond_to do |format|
      if @newsletter.update(newsletter_params)
        format.html { 
          if request.xhr? 
            render nothing: true
          else
            redirect_to newsletters_path
          end 
          }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newsletters/1
  # DELETE /newsletters/1.json
  def destroy
    @newsletter.destroy
    respond_to do |format|
      format.html { redirect_to newsletters_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newsletter_params
      params.permit!.except(:action, :controller, :_method, :authenticity_token)
    end
end
