class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |bid|
        csv << bid.attributes.values_at(*column_names)
      end
    end
  end
end
