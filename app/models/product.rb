class Product < ApplicationRecord
  has_many :bids

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
end
