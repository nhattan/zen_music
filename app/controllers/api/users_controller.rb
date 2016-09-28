class Api::UsersController < Api::ApplicationController

  def profile
    @user = current_user
  end
end
