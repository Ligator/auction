FactoryBot.define do
  factory :user do
    first_name { "Alfredo" }
    last_name {"José"}
    admin { false }
    phone {"9511223543"}
    sequence(:email) { |x| "Alfre.jangeles#{x}@hotmail.com" }
    password {"contraseña12345"}
    password_confirmation {"contraseña12345"}
  end
end
