class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update ]
  before_action :load_categories

  def index
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
  end

  def create
    creation_service = TransactionCreator.new(user: User.first, params: transaction_params)
    if creation_service.create
      redirect_to transactions_path
    else
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    update_service = TransactionUpdater.new(transaction: @transaction, params: transaction_params)
    if update_service.update
      redirect_to @transaction
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:category_id, :amount, :description, :transaction_type, :date, :tags, :photo)
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

  def attach_photo(transaction, photo)
    transaction.photo.attach(photo)
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def load_categories
    @categories = Category.all
  end
end
