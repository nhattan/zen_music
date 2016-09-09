class Api::UsersController < Api::ApplicationController

  def show
    @user = User.confirmed.find params[:id]
  end
end
