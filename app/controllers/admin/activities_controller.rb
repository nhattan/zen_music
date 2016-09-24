class Admin::ActivitiesController < Admin::ApplicationController

  def index
    @activities = Activity.without_unliked.includes(:user, subject: [:audio]).order(created_at: :desc)
  end
end
