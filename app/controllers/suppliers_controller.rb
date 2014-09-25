class SuppliersController < ApplicationController
  before_action :set_supplier, except: [:index, :create, :new, :list]

  def index
    @suppliers = Supplier.all
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

  def url

    return unless params[:id]

    if params[:bill_id] and bill = Bill.find(params[:bill_id])
      bill_payment_url = bill.payment_url
    end

    if bill_payment_url
      payment_url = bill_payment_url
    elsif @supplier = Supplier.find(params[:id])
      payment_url = @supplier.payment_url
    else
      payment_url = nil
    end

    render json: payment_url.to_json if payment_url

   end
  
  def list
       
    if params[:bill_id] and bill = Bill.find(params[:bill_id])
      bill_supplier_id = bill.supplier_id 
      bill_payment_url = bill.payment_url
    end
    
    ddData = []
    
    Supplier.all.each do |supplier| 
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
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit!
  end
end
