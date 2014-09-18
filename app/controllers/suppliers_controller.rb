class SuppliersController < ApplicationController

  def url
    return unless params[:id]
    supplier = Supplier.find(params[:id])
    render json: supplier.payment_url.to_json if supplier
   end

end
