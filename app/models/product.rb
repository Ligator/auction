class Product < ApplicationRecord
  has_many :bids

  ROUND_FACTOR = 10

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def max_bid_amount
    bids.maximum(:amount)
  end

  def next_bid_amount
    next_bid_amount = (max_bid_amount.to_d / ROUND_FACTOR).ceil * ROUND_FACTOR
    next_bid_amount == max_bid_amount ? max_bid_amount + 10 : max_bid_amount
  end
end
