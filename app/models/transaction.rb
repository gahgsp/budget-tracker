class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum :transaction_type, { income: 0, expense: 1 }

  # "Scopes" are a way to extract commonly-used queries that can be called as functions.
  scope :filter_by_type, ->(type) { where(transaction_type: type) if type.present? }
  scope :filter_by_category, ->(category) { where(category_id: category) if category.present? }

  validates_with PositiveAmountValidator
end
