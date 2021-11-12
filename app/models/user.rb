class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bids

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :admin, presence: true
  validates :phone, presence: true, length: { minimum: 10}
end
