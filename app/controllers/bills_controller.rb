class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]
  before_action :set_section
  autocomplete  :supplier, :name, :full => true

  def import

    return unless 
      customer_id =   params[:customer_id] and 
      newsletter_id = params[:newsletter_id] and 
      section =       params[:section]
    customer = Customer.find(customer_id)

    if customer.import_alpha_bills_to_newsletter(newsletter_id, section)
      notice = "Alpha bills successfully imported. Please validate the data!" 
      redirect_to customer_newsletter_bills_path(customer.id, newsletter_id, section: params[:section]), notice: notice
    else
      flash[:error] = "No import done: " + customer.errors.full_messages.to_sentence
      redirect_to customer_newsletter_bills_path(customer.id, newsletter_id, section: params[:section])
    end

 end

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
    @due = @bill.dues.build(newsletter_id: params[:newsletter_id]) if @section == 'dues'
    @notification = @bill.notifications.build(newsletter_id: params[:newsletter_id]) if @section == 'notifications'
  end

  # GET /bills/1/edit
  def edit
    @bill = Bill.find(params[:id])
  end

  # POST /bills
  # POST /bills.json
  def create
   supplier_added = Supplier.no_existent?(bill_params[:supplier_name])
    @bill = @customer.bills.new(bill_params)
    respond_to do |format|
      if @bill.save 
        format.html { 
          if supplier_added and new_supplier = Supplier.find_by_name(bill_params[:supplier_name])
            redirect_to supplier_path(new_supplier.id), notice: 'You have defined a new supplier. Update it here' 
          else
            redirect_to customer_newsletter_bills_path(@customer, @newsletter, section: @section), notice: 'Bill was successfully created.' 
          end
        }
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
    
    supplier_added = Supplier.no_existent?(bill_params[:supplier_name])
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { 
          if supplier_added and new_supplier = Supplier.find_by_name(bill_params[:supplier_name])
            redirect_to supplier_path(new_supplier.id), notice: 'You have defined a new supplier. Update it here' 
          else
            redirect_to customer_newsletter_bills_path(@customer, @newsletter, section: @section), notice: 'Bill was successfully updated.' 
          end
        }
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
      format.html { redirect_to customer_newsletter_bills_url(@customer, @newsletter, section: params[:section]) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end
    
    def set_section
      if params[:section]
        @section = params[:section]
      elsif params[:bill] and params[:bill][:section]
        @section = params[:bill][:section]
      else
#        redirect_to root_path, notice: "No section param"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params[:bill].permit!
    end
end
