class Api::ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Api::ErrorHandling

  before_action :authenticate_user!
  before_action :authenticate_eligible_user!

  private
  def authenticate_eligible_user!
    unless current_user.eligible?
      raise Api::Exception.new "auth.user_is_not_eligible"
    end
  end
end
