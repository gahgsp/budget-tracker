class Tag < ApplicationRecord
  has_many :transaction_tags, dependent: :destroy
  has_many :transactions, through: :transaction_tags
end
