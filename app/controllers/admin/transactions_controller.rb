class Admin::TransactionsController < Admin::ApplicationController
  before_action :set_transaction, only: [:show]
  before_action :filter_transactions, only: [:index]

  def index
    @transactions = @transactions.includes(:user).order(created_at: :desc).page(params[:page]).per(Setting.admin_per_page)
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

    def filter_transactions
      if params[:date_range_filter].present?
        from, to = params[:date_range_filter].split(' - ')
        from = DateTime.strptime(from, Setting.date_format).to_time
        to = DateTime.strptime(to, Setting.date_format).end_of_day.to_time
        @transactions = Transaction.where(created_at: from..to)
      else
        @transactions = Transaction.all
      end
    end
end
