class TransactionsController < ApplicationController
  def index
    @categories = Category.all

    @transactions = Transaction
      .includes(:category, :user)
      .filter_by_type(params[:type])
      .filter_by_category(params[:category_id])

    @total_income = @transactions.income.sum(:amount)
    @total_expense = @transactions.expense.sum(:amount)
    @total_balance = @total_income - @total_expense
  end

  def new
    @transaction = Transaction.new
    @categories = Category.all
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = User.first # This is temporary until we have user register.

    if @transaction.save
      redirect_to transactions_path
    else
      # In case of error,
      # we need to reload all the "Categories" so we can populate it's field in the Creation Form.
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:category_id, :amount, :description, :transaction_type, :date)
  end
end
