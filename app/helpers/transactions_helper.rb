module TransactionsHelper
  def build_transaction_types_for_filter
    [ [ "All", "" ] ] + Transaction.transaction_types.keys.map { |type| [ type.humanize, type ] }
  end
end
