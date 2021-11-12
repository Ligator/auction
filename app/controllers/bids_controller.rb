class BidsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
  end

  def create
  end
end
