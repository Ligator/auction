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

  product_attributes = [
    { image_url: "BlusaTlahui.jpg", name: "Blusa Tlahuitoltepec", description: "Maestra artesana: Adela Jimenez del colectivo #GuendaShunashi y participante del programa #MujeresAVE Descripción del producto: Blusa de manta con bordado artesanal, de colores rojo y negro tradicionales de Tlahuitoltepec, Mixes. El tiempo de elaboración  consta de 4 días.  Talla: Mediana  Medidas: 43 cm de ancho de espalda y 67 cm de largo" },
    { image_url: "Adri1.jpg", name: "Salvavidas arte", description: "" },
    { image_url: "Adri2.jpg", name: "Salvavidas arte galería", description: "" },
    { image_url: "MujerTrazos.jpg", name: "Pintura rostro de mujer", description: "Pintura del rostro de una mujer con figuras geométricas." },
    { image_url: "DamaBici.jpg", name: "Dama Bici", description: "Una replica realizada con acrilicos sobre madera, representa a una dama posando sobre una bicicleta." },
    { image_url: "Virgen.jpg", name: "Virgen", description: "Virgen Maria, oleo sobre papel" },
    { image_url: "Vela.jpg", name: "Bodegon vela", description: "Bodegon, acrilico sobre tela" },
    { image_url: "Garou.jpg", name: "Garou", description: "" },
    { image_url: "SetRosa.jpg", name: "Set cubrebocas rosa", description: "Maestra artesana: Celia Martínez del colectivo #GuendaShunashi y participante del programa #MujeresAVE Descripción del producto: Set de cubrebocas de telar, incluye dos piezas." },
    { image_url: "SetCafe.jpg", name: "Set cubrebocas café", description: "Maestra artesana: Celia Martínez del colectivo #GuendaShunashi y participante del programa #MujeresAVE Descripción del producto: Set de cubrebocas de telar, incluye dos piezas." },
    { image_url: "Muneca.jpg", name: "Muñeca Tlahuitoltepec", description: "Maestra artesana: Celia Martínez del colectivo #GuendaShunashi y participante del programa #MujeresAVE Descripción del producto: Muñeca hecha a mano, con accesorios tradicionales de Tlahuitoltepec, Mixes. " },
    { image_url: "OjoGirasol.jpg", name: "Ojos color sol", description: "Dibujo a mano con lápiz, mezclando los tonos oscuros con los vivos colores para dar una presentación más gráfica de como se siente el vivo de los ojos de cualquier color." },
    { image_url: "Vereda.jpg", name: "Vereda", description: "" },
    { image_url: "DamaNegro.jpg", name: "Dama negro", description: "" },
    { image_url: "Dragon.jpg", name: "Dibujo dragón", description: "Es un dibujo de un dragón a lapiz, con técnica de degradación." },
    { image_url: "Jamiltepec.jpg", name: "Blusa Jalapa lima", description: "Blusa artesanal región del Papaloapan del municipio de Jalapa de Díaz, en el estado de Oaxaca. Tiempo de elaboración es de un mes. Talla: Unitalla Medidas: ancho 50 cm " },
    { image_url: "Colores.jpg", name: "Blusa Jalapa colores", description: "Blusa artesanal región del Papaloapan del municipio de Jalapa de Díaz, en el estado de Oaxaca. Tiempo de elaboración es de un mes. Talla: Unitalla Medidas: ancho 50 cm " },
    { image_url: "HombreRojo.jpg", name: "Hombre pensante", description: "Dibujo a tonos rojos de hombre solo se utilizo lápices de tonos rojos, su tamaño es 31 cm de altura y 25 cm de ancho, fue hecho en hoja de 150g" },
    { image_url: "Dino.jpg", name: "Reptil Cornudo", description: "Dibujo de teropodo carnívoro cada detalle se realizo  a lápiz mide 31x25 cm hecho en hoja de 150g" },
    { image_url: "Limas.jpg", name: "Bodegón Limas", description: "Es un bodegón de dos limas, pintado con acuarela ." },
    { image_url: "SetPalma.jpg", name: "Set de bolsas palma narutal", description: "Bolsas redondas de palma natural, es un set de dos piezas. Medias pieza 1: 21 cm diam 22 cm + 15 cm asas Pieza 2: diam 22 27 alto + 15 cm asas" },
    { image_url: "Bolsa.jpg", name: "Bolsa de palma natrual", description: "40 ancho 32 alto + 19 asas" },
    { image_url: "Aretes.jpg", name: "Aretes bordado chatino", description: "Maestra artesana: Soledad Zurita del colectivo #GuendaShunashi y participante del programa #MujeresAVE Producto: " },
    { image_url: "Leia.jpg", name: "Leía", description: "" }
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

  User.create({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone: Faker::PhoneNumber.cell_phone,
    email: "login@example.com",
    password: "123456",
    password_confirmation: "123456",
    admin: true
  })

  product_attributes.each do |product_attribute|
    product = Product.create product_attribute
    rand(1..15).times do |n|
      Bid.create amount: n * 10, product: product, user_id: users.sample.id
    end
  end

elsif  Rails.env.production?
  Bid.delete_all
  Product.destroy_all
  User.destroy_all

  product_attributes = [
    { image_url: "BlusaTlahui.jpg", name: "Blusa Tlahuitoltepec", description: "Maestra artesana: Adela Jimenez del colectivo #GuendaShunashi y participante del programa #MujeresAVE Descripción del producto: Blusa de manta con bordado artesanal, de colores rojo y negro tradicionales de Tlahuitoltepec, Mixes. El tiempo de elaboración  consta de 4 días.  Talla: Mediana  Medidas: 43 cm de ancho de espalda y 67 cm de largo" },
    { image_url: "Adri1.jpg", name: "Salvavidas arte", description: "" },
    { image_url: "Adri2.jpg", name: "Salvavidas arte galería", description: "" },
    { image_url: "MujerTrazos.jpg", name: "Pintura rostro de mujer", description: "Pintura del rostro de una mujer con figuras geométricas." },
    { image_url: "DamaBici.jpg", name: "Dama Bici", description: "Una replica realizada con acrilicos sobre madera, representa a una dama posando sobre una bicicleta." },
    { image_url: "Virgen.jpg", name: "Virgen", description: "Virgen Maria, oleo sobre papel" },
    { image_url: "Vela.jpg", name: "Bodegon vela", description: "Bodegon, acrilico sobre tela" },
    { image_url: "Garou.jpg", name: "Garou", description: "" },
    { image_url: "SetRosa.jpg", name: "Set cubrebocas rosa", description: "Maestra artesana: Celia Martínez del colectivo #GuendaShunashi y participante del programa #MujeresAVE Descripción del producto: Set de cubrebocas de telar, incluye dos piezas." },
    { image_url: "SetCafe.jpg", name: "Set cubrebocas café", description: "Maestra artesana: Celia Martínez del colectivo #GuendaShunashi y participante del programa #MujeresAVE Descripción del producto: Set de cubrebocas de telar, incluye dos piezas." },
    { image_url: "Muneca.jpg", name: "Muñeca Tlahuitoltepec", description: "Maestra artesana: Celia Martínez del colectivo #GuendaShunashi y participante del programa #MujeresAVE Descripción del producto: Muñeca hecha a mano, con accesorios tradicionales de Tlahuitoltepec, Mixes. " },
    { image_url: "OjoGirasol.jpg", name: "Ojos color sol", description: "Dibujo a mano con lápiz, mezclando los tonos oscuros con los vivos colores para dar una presentación más gráfica de como se siente el vivo de los ojos de cualquier color." },
    { image_url: "Vereda.jpg", name: "Vereda", description: "" },
    { image_url: "DamaNegro.jpg", name: "Dama negro", description: "" },
    { image_url: "Dragon.jpg", name: "Dibujo dragón", description: "Es un dibujo de un dragón a lapiz, con técnica de degradación." },
    { image_url: "Jamiltepec.jpg", name: "Blusa Jalapa lima", description: "Blusa artesanal región del Papaloapan del municipio de Jalapa de Díaz, en el estado de Oaxaca. Tiempo de elaboración es de un mes. Talla: Unitalla Medidas: ancho 50 cm " },
    { image_url: "Colores.jpg", name: "Blusa Jalapa colores", description: "Blusa artesanal región del Papaloapan del municipio de Jalapa de Díaz, en el estado de Oaxaca. Tiempo de elaboración es de un mes. Talla: Unitalla Medidas: ancho 50 cm " },
    { image_url: "HombreRojo.jpg", name: "Hombre pensante", description: "Dibujo a tonos rojos de hombre solo se utilizo lápices de tonos rojos, su tamaño es 31 cm de altura y 25 cm de ancho, fue hecho en hoja de 150g" },
    { image_url: "Dino.jpg", name: "Reptil Cornudo", description: "Dibujo de teropodo carnívoro cada detalle se realizo  a lápiz mide 31x25 cm hecho en hoja de 150g" },
    { image_url: "Limas.jpg", name: "Bodegón Limas", description: "Es un bodegón de dos limas, pintado con acuarela ." },
    { image_url: "SetPalma.jpg", name: "Set de bolsas palma narutal", description: "Bolsas redondas de palma natural, es un set de dos piezas. Medias pieza 1: 21 cm diam 22 cm + 15 cm asas Pieza 2: diam 22 27 alto + 15 cm asas" },
    { image_url: "Bolsa.jpg", name: "Bolsa de palma natrual", description: "40 ancho 32 alto + 19 asas" },
    { image_url: "Aretes.jpg", name: "Aretes bordado chatino", description: "Maestra artesana: Soledad Zurita del colectivo #GuendaShunashi y participante del programa #MujeresAVE Producto: " },
    { image_url: "Leia.jpg", name: "Leía", description: "" }
  ]

  password = rand(99999999)
  User.create({
    first_name: "Joss",
    last_name: "Cruz",
    phone: "951 123 4567",
    email: "emprende.ecoosmx@gmail.com",
    password: password,
    password_confirmation: password,
    admin: true
  })

  product_attributes.each do |product_attribute|
    Product.create product_attribute
  end
end
