require "rails_helper"
require "devise"
require 'spec_helper'

describe BidsController do
  it "creates a new bit for product with valid params" do
    @current_user = FactoryBot.create :user
    product = FactoryBot.create :product
    sign_in(@current_user, scope: :user)

    expect{
      post :create, params: { product_id: product.id, bids: { amount: "90"}, commit: "Ofertar" }
    }.to change { Bid.count }.by(1)

    expect(flash[:notice]).to eq("Tu oferta se ha enviado")
  end

  it "doesn't create a new bit for product with invalid params" do
    @current_user = FactoryBot.create :user
    product = FactoryBot.create :product
    sign_in(@current_user, scope: :user)

    expect{
      post :create, params: { product_id: product.id, bids: { amount: ""}, commit: "Ofertar" }
    }.to change { Bid.count }.by(0)

    expect(flash[:alert]).to eq("Tu oferta es menor a la oferta actual")
  end

  it "doesn't create a new bit for product with invalid params" do
    @current_user = FactoryBot.create :user
    product = FactoryBot.create :product
    sign_in(@current_user, scope: :user)

    expect{
      post :create, params: { product_id: nil, bids: { amount: ""}, commit: "Ofertar" }
    }.to change { Bid.count }.by(0)

    expect(flash[:alert]).to eq("No se puede crear una oferta para un producto vacío.")
  end
end

