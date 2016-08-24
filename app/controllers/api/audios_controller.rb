class Api::AudiosController < Api::ApplicationController
  def index
    @audios = Audio.approved
  end

  def show
    @audio = Audio.approved.find params[:id]
    @listen = current_user.listens.create audio: @audio
  end

  def top
    @audios = Audio.top.limit(10)
  end
end
