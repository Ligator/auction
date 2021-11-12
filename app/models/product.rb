class Product < ApplicationRecord
  has_many :bids

  ROUND_FACTOR = 10

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      col_names = column_names.dup
      col_names.delete("image_url")
      csv << col_names
      all.each do |product|
        csv << product.attributes.values_at(*col_names)
      end
    end
  end

  def max_bid_amount
    bids.maximum(:amount)
  end

  def next_bid_amount
    next_bid_amount = (max_bid_amount.to_d / ROUND_FACTOR).ceil * ROUND_FACTOR
    next_bid_amount == max_bid_amount ? max_bid_amount + ROUND_FACTOR : max_bid_amount
  end
end
