class HomeController < ApplicationController
  skip_authorize_resource

  def index
    redirect_to ENV['LANDING_PAGE_URL']
  end
end
