class SuppliersController < ApplicationController

  def url
    return unless params[:id]
    supplier = Supplier.find(params[:id])
    render json: supplier.payment_url.to_json if supplier
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
        imageSrc:     image_url("globes.jpg"),
        payment_url:  bill_payment_url || supplier.payment_url
        }
    end
    
    render json: ddData

  end

  def list1
    ddData = [
    {
        text: "Facebook",
        value: 1,
        selected: false,
        description: "Description with Facebook",
        imageSrc: image_url("globes.jpg")
    },
    {
        text: "Twitter",
        value: 2,
        selected: false,
        description: "Description with Twitter",
        imageSrc: image_url("globes.jpg")
    },
    {
        text: "LinkedIn",
        value: 3,
        selected: false,
        description: "Description with LinkedIn",
        imageSrc: image_url("globes.jpg")
    },
    {
        text: "Foursquare",
        value: 4,
        selected: false,
        description: "Description with Foursquare",
        imageSrc: image_url("globes.jpg")
    }
];

    render json: ddData
  end
end
