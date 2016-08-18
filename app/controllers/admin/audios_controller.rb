class Admin::AudiosController < Admin::ApplicationController
  before_action :set_audio, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category_id].present?
      @category = Category.find params[:category_id]
      @audios = @category.audios.page(params[:page]).per(20)
    else
      @audios = Audio.includes(:category).page(params[:page]).per(20)
    end
  end

  def show
  end

  def new
    @audio = Audio.new
  end

  def edit
  end

  def create
    @audio = Audio.new(audio_params)
    respond_to do |format|
      if @audio.save
        format.html { redirect_to admin_audio_url(@audio), notice: 'Audio was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @audio.update(audio_params)
        format.html { redirect_to admin_audio_url(@audio), notice: 'Audio was successfully updated.' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def destroy
    @audio.destroy
    respond_to do |format|
      format.html { redirect_to admin_audios_url, notice: 'Audio was successfully destroyed.' }
    end
  end

  private
    def set_audio
      @audio = Audio.find(params[:id])
    end

    def audio_params
      params.require(:audio).permit(:name, :description, :uploaded_file, :uploaded_file_cache, :category_id, :status)
    end
end
