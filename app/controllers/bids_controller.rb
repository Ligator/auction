class BidsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @products = Product.all.shuffle
  end

  def create
    product = Product.find(params[:product_id])

    return_with_error_message and return if params[:bids][:amount].to_d <= product.max_bid_amount.to_d

    dib = product.bids.new(amount: params[:bids][:amount], user_id: current_user.id)

    if dib.save
      flash[:notice] = "Tu oferta se ha enviado"
      redirect_to root_path
    else
      flash[:alert] = dib.errors.full_messages.join(",")
    end
  end

  def return_with_error_message
    flash[:alert] = "Tu oferta es menor a la oferta actual"
    redirect_to root_path
  end
end
