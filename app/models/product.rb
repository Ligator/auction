class Product < ApplicationRecord
  has_many :bids

  def max_bid
    bids.maximum(:amount)
  end
end
