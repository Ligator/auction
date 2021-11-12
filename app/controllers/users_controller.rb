class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.xls { send_data @users.to_csv(col_sep: "\t") }
      format.csv { send_data @users.to_csv }
    end
  end
end
