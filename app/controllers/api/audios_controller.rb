class Api::AudiosController < ApiController
  def index
    @audios = Audio.approved
  end

  def show
    @audio = Audio.approved.find params[:id]
  end
end
