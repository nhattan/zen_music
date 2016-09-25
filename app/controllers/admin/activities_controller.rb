class Admin::ActivitiesController < Admin::ApplicationController

  def index
    @activities = Activity.includes(:user, subject: [:audio]).order(created_at: :desc)
  end
end
