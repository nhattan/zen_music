class Api::LikesController < Api::ApplicationController
  before_action :get_audio, only: [:create]

  def create
    like = @audio.likes.create user: current_user
    @audio = like.audio
  end

  private
  def get_audio
    @audio = Audio.approved.find params[:audio_id]
  end
end
