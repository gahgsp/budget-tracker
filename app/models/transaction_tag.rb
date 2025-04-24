class TransactionTag < ApplicationRecord
  # The name "transaction" is a reserved name for an Active Record.
  # Therefore, we need to name the association with a different value.
  # Using the "class_name" we make sure that Rails knows which Table to associate.
  belongs_to :trx, class_name: "Transaction"
  belongs_to :tag
end
