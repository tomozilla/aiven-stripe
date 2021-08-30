class ElementsController < ApplicationController
    def new
        @order = Order.find(params[:order_id])
        @current_user = current_user
    end

    def redirect
        redirect_to order_path(params[:id]) 
    end

end
