class CartItemsController < ApplicationController
  before_action :authenticate_user! , only: [:checkout]

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    @product = @cart_item.product
    @cart_item.destroy

    flash[:warning] = "成功将 #{@product.title} 从购物车删除!"
    redirect_to :back
  end

  def update
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])

    if @cart_item.product.quantity >= cart_item_params[:quantity].to_i
      @cart_item.update(cart_item_params)
      flash[:notice] = "成功变更数量"
    else
      flash[:warning] = "数量不足以加入购物车"
    end

    redirect_to carts_path
  end

  def add_quantity
    @cart_item = current_cart.cart_items.find_by_product_id(params[:id])
    if @cart_item.quantity < @cart_item.product.quantity
         @cart_item.quantity += 1
         @cart_item.save

    elsif @cart_item.quantity == @cart_item.product.quantity

    end
  end

  def remove_quantity
    @cart_item = current_cart.cart_items.find_by_product_id(params[:id])
    if @cart_item.quantity > 0
         @cart_item.quantity -= 1
         @cart_item.save
         render "add_quantity"
    elsif @cart_item.quantity == 0
         render "add_quantity"
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

end
