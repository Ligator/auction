class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user_is_not_admin?

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.xls { send_data @users.to_csv(col_sep: "\t") }
      format.csv { send_data @users.to_csv }
    end
  end
end
