class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :transaction_tags, foreign_key: :trx_id, dependent: :destroy
  # Due to this "has_many", Rails already creates a getter / setter for the "tags" property.
  # This way we can access this property directly from this Transaction entity.
  has_many :tags, through: :transaction_tags

  enum :transaction_type, { income: 0, expense: 1 }

  # This macro sets up a one-to-one relationship between a Transaction and an Uploaded File.
  has_one_attached :photo

  # "Scopes" are a way to extract commonly-used queries that can be called as functions.
  scope :filter_by_type, ->(type) { where(transaction_type: type) if type.present? }
  scope :filter_by_category, ->(category) { where(category_id: category) if category.present? }
  scope :from_date, ->(date) { where("date >= ?", date) if date.present? }
  scope :to_date, ->(date) { where("date <= ?", date) if date.present? }

  validates_with PositiveAmountValidator
end
