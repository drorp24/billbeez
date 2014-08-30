class ChargesController < ApplicationController
  before_action :set_charge

  # GET /charges
  # GET /charges.json
  def index
  end

  # GET /charges/1
  # GET /charges/1.json
  def show
  end

  # GET /charges/new
  def new
    @charge = Charge.new
  end

  # GET /charges/1/edit
  def edit
  end

  # POST /charges
  # POST /charges.json
  def create
    @charge = @notification.charges.build(charge_params)

    respond_to do |format|
      if @charge.save
        format.html { redirect_to customer_newsletter_bills_path(@customer, @newsletter, section: "notifications"), notice: 'charge was successfully created.' }
        format.json { render action: 'show', status: :created, location: @charge }
      else
        format.html { render action: 'new' }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /charges/1
  # PATCH/PUT /charges/1.json
  def update
    respond_to do |format|
      if @charge.update(charge_params)
        format.html { redirect_to customer_newsletter_bills_path(@customer, @newsletter, section: "notifications"), notice: 'charge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charges/1
  # DELETE /charges/1.json
  def destroy
    @charge.destroy
    respond_to do |format|
      format.html { redirect_to customer_newsletter_bills_path(@customer, @newsletter, section: "notifications")}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_charge
      @charge = Charge.find(params[:id]) if params[:id]
      @notification_id = params[:notification_id]
      @notification = Notification.find(@notification_id) if @notification_id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def charge_params
      params[:charge].permit!
    end
end
