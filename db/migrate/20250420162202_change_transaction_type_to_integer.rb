class ChangeTransactionTypeToInteger < ActiveRecord::Migration[8.0]
  def change
    # 1 - Updates the data in the column but now using "integer" values.
    execute <<-SQL
      UPDATE transactions SET transaction_type = 0 WHERE transaction_type = 'income';
      UPDATE transactions SET transaction_type = 1 WHERE transaction_type = 'expense';
    SQL

    # 2 - Updates the column to have the type "integer".
    change_column :transactions, :transaction_type, :integer, using: 'transaction_type::integer'
  end
end
