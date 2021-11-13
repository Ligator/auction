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
      col_names = column_names.dup
      col_names.delete("encrypted_password")
      col_names.delete("reset_password_token")
      col_names.delete("reset_password_sent_at")
      col_names.delete("remember_created_at")
      col_names.delete("admin")
      csv << col_names
      all.each do |user|
        created_at = user.attributes["created_at"]
        updated_at = user.attributes["updated_at"]
        attributes =
          user
            .attributes
            .merge("created_at"=>created_at.strftime("%d/%m/%Y - %H:%M"),
                   "updated_at"=>updated_at.strftime("%d/%m/%Y - %H:%M"))
        csv << attributes.values_at(*col_names)
      end
    end
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
end
