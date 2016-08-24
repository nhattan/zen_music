class Api::LikesController < Api::ApplicationController
  before_action :get_audio, only: [:create, :destroy]

  def create
    like = @audio.likes.create! user: current_user
    @audio = like.audio
  end

  def destroy
    like = @audio.likes.find_by! user_id: current_user.id
    like.destroy
    @audio = @audio.reload
  end

  private
  def get_audio
    @audio = Audio.approved.find params[:audio_id]
  end
end
