class TransactionsController < ApplicationController
  def index
    # First, we load everything (all the rows).
    @categories = Category.all
    @transactions = Transaction.all.includes(:category, :user)

    # Then, we apply the filters if they are present in the URL.
    @transactions = @transactions.where(transaction_type: params[:type]) if params[:type].present?
    @transactions = @transactions.where(category_id: params[:category_id]) if params[:category_id].present?
  end

  def new
    @transaction = Transaction.new
    @categories = Category.all
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = User.first # temporary hardcoded user
    if @transaction.save
      redirect_to transactions_path
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:category_id, :amount, :description, :transaction_type, :date)
  end
end
