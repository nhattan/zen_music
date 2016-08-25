class Admin::TransactionsController < Admin::ApplicationController
  before_action :set_transaction, only: [:show]

  def index
    @transactions = Transaction.includes(:user).order(created_at: :desc).page(params[:page]).per(Setting.admin_per_page)
  end

  def show
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to admin_transaction_url(@transaction), notice: 'Transaction was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:user_id, :amount)
    end
end
