class Admin::DashboardController < Admin::ApplicationController
  skip_authorize_resource

  def index
    @activities = Activity.without_unliked.includes(:user, subject: [:audio]).order(created_at: :desc).limit(4)
  end
end
