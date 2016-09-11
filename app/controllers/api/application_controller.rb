class Api::ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Api::ErrorHandling

  before_action :authenticate_user!
  before_action :authenticate_privileged_user!

  private
  def authenticate_privileged_user!
    unless current_user.privileged?
      raise Api::Exception.new "auth.user_is_not_privileged"
    end
  end
end
