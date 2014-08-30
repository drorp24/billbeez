class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  # GET /bills
  # GET /bills.json
  def index
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    
  end

  # GET /bills/new
  def new
    @bill = Bill.new
    @due = @bill.dues.build(newsletter_id: params[:newsletter_id]) if params[:section] == 'dues'
    @notification = @bill.notifications.build(newsletter_id: params[:newsletter_id]) if params[:section] == 'notifications'
  end

  # GET /bills/1/edit
  def edit
#    @due = @bill.dues.first
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = @customer.bills.new(bill_params)
    respond_to do |format|
      if @bill.save 
        format.html { redirect_to customer_newsletter_bills_path(@customer, @newsletter, section: params[:bill][:section]), notice: 'Bill was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bill }
      else
        format.html { render action: 'new' }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to customer_newsletter_bills_path(@customer, @newsletter), notice: 'Bill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to customer_newsletter_bills_url(@customer, @newsletter) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params[:bill].permit!
    end
end
