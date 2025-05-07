class TransactionCreator
  include TransactionHelper
  # The "initialize" function is the constructor in Ruby.
  # It is executed when calling "new" to create an instance.
  # Having parameters with : in the function definition define them as "named parameters".
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def create
    @transaction = Transaction.new(@params.except(:tags))
    @transaction.user = @user

    if @transaction.save
      associate_tags(transaction: @transaction, params: @params)
      attach_photo(transaction: @transaction, params: @params)
      true
    else
      false
    end
  end
end
