# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

if Rails.env.development?
  Bid.delete_all
  Product.destroy_all
  User.destroy_all

  product_names = %w[
    BlusaTlahui.jpg
    Adri1.jpg
    Adri2.jpg
    MujerTrazos.jpg
    DamaBici.jpg
    Virgen.jpg
    Vela.jpg
    Garou.jpg
    SetRosa.jpg
    SetCafe.jpg
    Muñeca.jpg
    OjoGirasol.jpg
    Vereda.jpg
    DamaNegro.jpg
    Dragon.jpg
    Jamiltepec.jpg
    Colores.jpg
    HombreRojo.jpg
    Dino.jpg
    Limas.jpg
    SetPalma.jpg
    Bolsa.jpg
    Aretes.jpg
    Leia.jpg
  ]

  users = (1..5).map do
    password = Faker::Hobby.activity

    User.create({
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone: Faker::PhoneNumber.cell_phone,
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password,
      admin: false
    })
  end

  product_names.each do |product_name|
    product = Product.create image_url: product_name, name: Faker::Movies::Ghostbusters.character, description: Faker::Movies::Ghostbusters.quote
    rand(1..15).times do |n|
      Bid.create amount: n * 10, product: product, user_id: users.sample.id
    end
  end

elsif  Rails.env.production?
  Bid.delete_all
  Product.destroy_all
  User.destroy_all

  product_names = %w[
    BlusaTlahui.jpg
    Adri1.jpg
    Adri2.jpg
    MujerTrazos.jpg
    DamaBici.jpg
    Virgen.jpg
    Vela.jpg
    Garou.jpg
    SetRosa.jpg
    SetCafe.jpg
    Muñeca.jpg
    OjoGirasol.jpg
    Vereda.jpg
    DamaNegro.jpg
    Dragon.jpg
    Jamiltepec.jpg
    Colores.jpg
    HombreRojo.jpg
    Dino.jpg
    Limas.jpg
    SetPalma.jpg
    Bolsa.jpg
    Aretes.jpg
    Leia.jpg
  ]

  password = Faker::Hobby.activity
  User.create({
    first_name: "Joss",
    last_name: "Cruz",
    phone: "951 123 4567",
    email: "emprende.ecoosmx@gmail.com",
    password: password,
    password_confirmation: password,
    admin: true
  })

  product_names.each do |product_name|
    Product.create image_url: product_name
  end
end
