class Admin::DashboardController < Admin::ApplicationController
  skip_authorize_resource

  def index
    redirect_to admin_transactions_path if current_user.agent?
    @activities = Activity.includes(:user, subject: [:audio]).order(created_at: :desc).limit(4)
  end
end
