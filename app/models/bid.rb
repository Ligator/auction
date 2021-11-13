class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :amount, presence: true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      col_names = ["ID", "Producto", "Oferta", "Usuario", "Creado", "Actualizado"]
      csv << col_names
      all.each do |bid|
        created_at = bid.attributes["created_at"]
        updated_at = bid.attributes["updated_at"]
        user_id = bid.attributes["user_id"]
        attributes =
          bid
            .attributes
            .merge("ID" => bid.id,
                   "Producto" => bid.product.name,
                   "Creado" => created_at.strftime("%d/%m/%Y - %H:%M"),
                   "Actualizado" => updated_at.strftime("%d/%m/%Y - %H:%M"),
                   "Usuario" => User.find(user_id).full_name,
                   "Oferta" => "$#{bid.amount}")
        csv << attributes.values_at(*col_names)
      end
    end
  end
end

