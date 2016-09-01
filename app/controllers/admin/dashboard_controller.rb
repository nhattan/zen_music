class Admin::DashboardController < Admin::ApplicationController

  def index
    @activities = Activity.includes(:user, subject: [:audio]).order(created_at: :desc).limit(4)
  end
end
