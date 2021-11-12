class Product < ApplicationRecord
  has_many :bids

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def max_bid
    bids.maximum(:amount)
  end
end
