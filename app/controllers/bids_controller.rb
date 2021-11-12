class BidsController < ApplicationController
  def index
    @products = Product.all.shuffle
  end

  def create
  end
end
