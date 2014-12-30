class NewslettersController < ApplicationController
  before_action :set_newsletter, only: [:deliver, :show, :edit, :update, :destroy]

  def deliver

#    @newsletter.deliver
    action = (params[:resend] and params[:resend] == 'yes') ? 'resent' : 'sent'
    notice = "Newsletter #{action} to #{@newsletter.customer.name}"
    notice = "Restart Mail Queue to deliver newsletter" 
    if params[:customer_id]
      redirect_to customer_newsletters_path(params[:customer_id]), notice: notice
    elsif params[:campaign_id]
      redirect_to campaign_newsletters_path(params[:campaign_id]), notice: notice
    end

  end


  # GET /newsletters
  # GET /newsletters.json
  def index

    @newsletters = Newsletter.includes(:customer, :campaign)

    if params[:customer_id]
      @newsletters = @newsletters.where(customer_id: params[:customer_id])
    end
    if params[:campaign_id]
      @newsletters = @newsletters.joins(:version).where(versions: {campaign_id: params[:campaign_id]})
    end

 end

  # GET /newsletters/1
  # GET /newsletters/1.json
  def show
  end

  # GET /newsletters/new
  def new

    # session to avoid creating another newsletter with every refresh
    redirect_to root_path, notice: "No customer id passed" and return unless customer_id = params[:customer_id]
    redirect_to root_path, notice: "Select campaign first" and return unless current_campaign
    redirect_to campaign_versions_path(current_campaign.id), notice: "No version exists that matches customer locale. You can create one here." and return unless version_id = current_campaign.version_of(customer_id)
    @customer = Customer.find(customer_id)
    @newsletter = @customer.newsletters.create(version_id: version_id)
    redirect_to customer_newsletter_path(customer_id, @newsletter.id)

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
      session[:newsletter_id] = @newsletter.id if @newsletter
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newsletter_params
      params.permit!.except(:action, :controller, :_method, :authenticity_token)
    end
end
