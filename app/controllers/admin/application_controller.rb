class Admin::ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :authenticate_admin

  layout 'admin_lte_2'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def authenticate_admin
    redirect_to root_path unless current_user.admin?
  end
end
