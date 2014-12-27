class SuppliersController < ApplicationController
  before_action :set_supplier, except: [:index, :create, :new, :list]

  def index
    @suppliers = Supplier.all
#    flash[:notice] = "For the full details click Edit"
  end
  
  def edit
  end
  
  def show    
  end
  
  def new
    @supplier = Supplier.new
  end
  
  def update
    @supplier.update(supplier_params)
    redirect_to suppliers_path, notice: "Supplier successfully updated"
  end
  
  def create 
     @supplier = Supplier.new(supplier_params)
     @supplier.save
     redirect_to suppliers_path, notice: "Supplier successfully created"
  end
  
  def destroy
    @supplier.destroy
    redirect_to suppliers_path
  end

  def payment_url

    return unless params[:supplier_name]

    if params[:bill_id] and bill = Bill.find(params[:bill_id])
      bill_payment_url = bill.payment_url_db
    end

    if bill_payment_url
      payment_url = bill_payment_url
    elsif @supplier = Supplier.find_by_name(params[:supplier_name])
      payment_url = @supplier.payment_url
    else
      payment_url = ""
    end

    render json: payment_url.to_json if payment_url

   end
  
  def list
       
    if params[:bill_id] and bill = Bill.find(params[:bill_id])
      bill_supplier_id = bill.supplier_id 
      bill_payment_url = bill.payment_url
    end
    
    ddData = []
    
    Supplier.order('name').each do |supplier| 
      ddData << 
        {
        text:         supplier.name,
        value:        supplier.id,
        selected:     supplier.id == bill_supplier_id,
        description:  supplier.description,
        imageSrc:     image_url(supplier.logo),
        payment_url:  bill_payment_url || supplier.payment_url
        }
    end
    
    render json: ddData

  end
  
  private
  
  def set_supplier
    @supplier = Supplier.find(params[:id]) if params[:id]
  end

  def supplier_params
    params.require(:supplier).permit!
  end
end
