class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |bid|
        created_at = bid.attributes["created_at"]
        updated_at = bid.attributes["updated_at"]
        attributes =
          bid
            .attributes
            .merge("created_at"=>created_at.strftime("%d/%m/%Y - %H:%M"),
                   "updated_at"=>updated_at.strftime("%d/%m/%Y - %H:%M"))
        csv << attributes.values_at(*column_names)
      end
    end
  end
end
