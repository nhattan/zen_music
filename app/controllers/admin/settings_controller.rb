class Admin::SettingsController < Admin::ApplicationController
  def index
  end

  def create
    respond_to do |format|
      if Setting.save_values setting_params
        format.html { redirect_to :back, notice: "Settings saved." }
      else
        format.html { render :index, alert: "Settings can not be saved." }
      end
    end
  end

  private
  def setting_params
    params.permit(:top_audio_quantity, :price, :admin_per_page, :app_name)
  end
end
