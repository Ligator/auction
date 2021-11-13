class Product < ApplicationRecord
  has_many :bids

  ROUND_FACTOR = 10

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      col_names = ["ID","Nombre","Descripción", "N° Ofertas", "Ultima Oferta", "Ofertante", "Teléfono", "Correo", "Creado", "Actualizado"]
      csv << col_names
      all.each do |product|
        created_at = product.attributes["created_at"]
        updated_at = product.attributes["updated_at"]
        attributes =
          product
            .attributes
            .merge("ID" => product.id,
                   "Nombre" => product.name,
                   "Descripción" => product.description,
                   "N° Ofertas" => product.bids.count,
                   "Ultima Oferta" => "$#{product.max_bid_amount}",
                   "Ofertante" => product.bids.last.user.full_name,
                   "Teléfono" => product.bids.last.user.phone,
                   "Correo" => product.bids.last.user.email,
                   "Creado"=>created_at.strftime("%d/%m/%Y - %H:%M"),
                   "Actualizado"=>updated_at.strftime("%d/%m/%Y - %H:%M"))
        csv << attributes.values_at(*col_names)
      end
    end
  end

  def max_bid_amount
    bids.maximum(:amount)
  end

  def next_bid_amount
    next_bid_amount = (((max_bid_amount.to_d + 0.1) / 10.0).ceil * 10) + 10
    next_bid_amount == max_bid_amount ? max_bid_amount : next_bid_amount
  end
end
