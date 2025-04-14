class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all.includes(:category, :user)
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
