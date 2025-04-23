class TransactionTag < ApplicationRecord
  belongs_to :trx, class_name: "Transaction"
  belongs_to :tag
end
