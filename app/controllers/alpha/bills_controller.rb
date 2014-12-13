class Alpha::BillsController < ApplicationController
  before_action :set_alpha_bill, only: [:show, :edit, :update, :destroy]

  # GET /alpha/bills
  # GET /alpha/bills.json
  def index
    @alpha_bills = Alpha::Bill.all
  end

  # GET /alpha/bills/1
  # GET /alpha/bills/1.json
  def show
  end

  # GET /alpha/bills/new
  def new
    @alpha_bill = Alpha::Bill.new
  end

  # GET /alpha/bills/1/edit
  def edit
  end

  # POST /alpha/bills
  # POST /alpha/bills.json
  def create
    @alpha_bill = Alpha::Bill.new(alpha_bill_params)

    respond_to do |format|
      if @alpha_bill.save
        format.html { redirect_to alpha_bills_path, notice: 'Bill was successfully created.' }
        format.json { render action: 'show', status: :created, location: @alpha_bill }
      else
        format.html { render action: 'new' }
        format.json { render json: @alpha_bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alpha/bills/1
  # PATCH/PUT /alpha/bills/1.json
  def update
    respond_to do |format|
      if @alpha_bill.update(alpha_bill_params)
        format.html { redirect_to alpha_bills_path, notice: 'Bill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @alpha_bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alpha/bills/1
  # DELETE /alpha/bills/1.json
  def destroy
    @alpha_bill.destroy
    respond_to do |format|
      format.html { redirect_to alpha_bills_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alpha_bill
      @alpha_bill = Alpha::Bill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alpha_bill_params
      params.require(:alpha_bill).permit(:Id, :providername, :fileLocation1, :IsShown, :UploadDate, :IsPaid, :InvoiceNumber, :InvoicePeriodFrom, :InvoicePeriodTo, :Amount, :PayDate, :fileLocation2, :Remark, :RemainderID, :PayNumber, :InvoiceDate, :fileLocation3, :fileLocation4)
    end
end
