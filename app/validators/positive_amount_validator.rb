class PositiveAmountValidator < ActiveModel::Validator
  def validate(record)
    if record.amount.present? && record.amount < 0
      record.errors.add :amount, "Amount should always be positive."
    end
  end
end
