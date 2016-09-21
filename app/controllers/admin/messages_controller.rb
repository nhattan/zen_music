class Admin::MessagesController < Admin::ApplicationController
  before_action :set_message, only: [:show, :destroy]

  def index
    @messages = Message.includes(:audio).order(created_at: :desc).page(params[:page]).per(Setting.admin_per_page)
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    respond_to do |format|
      if @message.save
        format.html { redirect_to admin_message_url(@message), notice: 'Message was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to admin_messages_url, notice: 'Message was successfully destroyed.' }
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:audio_id, :title, :body)
    end
end
