class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bids

  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :admin, presence: true
  validates :phone, presence: true, length: { minimum: 10}

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      col_names = ["ID", "Correo", "Nombre", "Apellidos", "Telefono", "Creado", "Actualizado"]
      csv << col_names
      all.each do |user|
        created_at = user.attributes["created_at"]
        updated_at = user.attributes["updated_at"]
        attributes =
          user
            .attributes
            .merge("ID" => user.id,
                   "Correo" => user.email,
                   "Nombre" => user.first_name,
                   "Apellidos" => user.last_name,
                   "Telefono" => user.phone,
                   "Creado"=>created_at.strftime("%d/%m/%Y - %H:%M"),
                   "Actualizado"=>updated_at.strftime("%d/%m/%Y - %H:%M"))
        csv << attributes.values_at(*col_names)
      end
    end
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def standard_phone
    phone
      .gsub(" ", "")
      .gsub("-", "")
      .gsub("(", "")
      .gsub(")", "")
      .gsub(".", "")
      .gsub("+", "")
  end

  def valid_phone?
    standard_phone.length == 10
  end

  def products_where_user_is_winning
    bids_whit_max_amount_ids = Product.all.map do |product|
      max_bid_amount = product.max_bid_amount
      if max_bid_amount && product.bids.present?
        [product.bids.where(amount: product.max_bid_amount).pluck(:id)]
      end
    end
    bids_whit_max_amount = Bid.where(id: bids_whit_max_amount_ids.flatten, user_id: id)
    products_user_winning = bids_whit_max_amount.map{|bid| bid.product}

    products_user_winning
  end
end
