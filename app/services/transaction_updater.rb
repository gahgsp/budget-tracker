class TransactionUpdater
  def initialize(transaction:, params:)
    @transaction = transaction
    @params = params
  end

  def update
    if @transaction.update(@params.except(:tags))
      associate_tags(@transaction, @params)
      attach_photo(@transaction, @params)
      true
    else
      false
    end
  end
end
