class BidsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @products = Product.all.shuffle
  end

  def create
  end
end
