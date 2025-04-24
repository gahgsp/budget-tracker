class TransactionsController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]

  def index
    @categories = Category.all

    @transactions = Transaction
      .includes(:category, :user)
      .filter_by_type(params[:type])
      .filter_by_category(params[:category_id])
      .from_date(params[:start_date])
      .to_date(params[:end_date])

    @total_income = @transactions.income.sum(:amount)
    @total_expense = @transactions.expense.sum(:amount)
    @total_balance = @total_income - @total_expense
  end

  def new
    @transaction = Transaction.new
    @categories = Category.all
  end

  def create
    @transaction = Transaction.new(transaction_params.except(:tags))
    @transaction.user = User.first # This is temporary until we have user register.

    if @transaction.save
      # If the Transaction is valid and we could save it, then we can create the related Tags.
      associate_tags(@transaction, transaction_params[:tags])
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
    params.require(:transaction).permit(:category_id, :amount, :description, :transaction_type, :date, :tags)
  end

  def associate_tags(transaction, tags_value)
    # logger.debug "Tags: #{tags_value}"
    return if tags_value.blank?

    tags_to_save = tags_value.split(",").map(&:strip).uniq

    saved_tags = tags_to_save.map do |name|
      Tag.find_or_create_by(name: name)
    end

    transaction.tags = saved_tags
  end
end
