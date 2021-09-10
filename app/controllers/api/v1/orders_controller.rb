# app/controllers/api/v1/restaurants_controller.rb
class Api::V1::OrdersController < ApplicationController
    skip_before_action :authenticate_user!

    def show
        @order = Order.find(params[:id])
    end
  
end
