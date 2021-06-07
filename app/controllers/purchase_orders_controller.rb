class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: %i[show edit update destroy print_order]
  layout false, only: %i[print_order]

  def index
    @purchase_orders = PurchaseOrder.all
  end
  
  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @purchase_order.update(purchase_order_params)
        format.html { redirect_to @purchase_order, notice: 'Order was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def print_order; end

  private

  def purchase_order_params
    params.require(:purchase_order).permit(:address, :city, :state, :customer_name, :country, :status)
  end
  

  def set_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end
end