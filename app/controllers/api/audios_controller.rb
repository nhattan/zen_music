class Api::AudiosController < Api::ApplicationController
  def index
    @audios = Audio.approved.includes(:category)
  end

  def show
    @audio = Audio.approved.find params[:id]
    @listen = current_user.listens.create! audio: @audio
  end

  def top
    @audios = Audio.includes(:category).top.limit(Setting.top_audio_quantity)
  end

  def favorite
    @audios = current_user.favorite_audios.includes(:category).order(created_at: :desc)
  end
end
