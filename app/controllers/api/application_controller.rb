class Api::ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Api::ErrorHandling

  before_action :authenticate_user!
end
