class BidsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @products = Product.all.shuffle
    search_products_where_user_is_winning
  end

  def create
    message = "No se puede crear una oferta para un producto vacío."
    return_with_error_message(message) and return if params[:product_id].blank?
    product = Product.find(params[:product_id])

    message = "Tu oferta es menor a la oferta actual"
    return_with_error_message(message) and return if params[:bids][:amount].to_d <= product.max_bid_amount.to_d

    product_ids = params[:product_ids_order].to_s.split(" ")
    if product_ids.present?
      @products = Product.find(product_ids)
    else
      @products = Product.all
    end

    search_products_where_user_is_winning
    @bid = product.bids.new(amount: params[:bids][:amount], user_id: current_user.id)

    if @bid.save
      @message = "Tu oferta se ha enviado"
      respond_to do |format|
        format.html do
          flash[:notice] = @message
          redirect_to bids_path
        end
        format.js
      end
    else
      respond_to do |format|
        @error_message = @bid.errors.full_messages.join(",")
        format.html do
          flash[:alert] = error_message
          redirect_to bids_path
        end
        format.js
      end
    end
  end

  def return_with_error_message(message)
    @error_message = message
    respond_to do |format|
      format.html do
        flash[:alert] = @error_message
        redirect_to bids_path
      end
      format.js
    end
  end

  def render_bids_row
    product_ids = params[:product_ids_order].to_s.split(" ")
    if product_ids.present?
      @products = Product.find(product_ids)
    else
      @products = Product.all
    end

    search_products_where_user_is_winning

    render layout: false
  end

  def search_products_where_user_is_winning
    return unless current_user.present?

    bids_whit_max_amount_ids = Product.all.map do |product|
      max_bid_amount = product.max_bid_amount
      if max_bid_amount && product.bids.present?
        [product.bids.where(amount: product.max_bid_amount).pluck(:id)]
      end
    end
    bids_whit_max_amount = Bid.where(id: bids_whit_max_amount_ids.flatten, user_id: current_user.id)
    @products_user_winning = bids_whit_max_amount.map{|bid| bid.product}
  end
end
