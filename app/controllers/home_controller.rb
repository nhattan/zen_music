class HomeController < ApplicationController

  def index
    redirect_to ENV['LANDING_PAGE_URL']
  end
end
