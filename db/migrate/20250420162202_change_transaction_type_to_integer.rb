class ChangeTransactionTypeToInteger < ActiveRecord::Migration[8.0]
  def up
    # 1 - First, we create a temporary column to hold "integer" values.
    add_column :transactions, :transaction_type_tmp, :integer

    # 2 - We migrate the data from "string" to "integer" in this new column.
    execute <<-SQL
      UPDATE transactions
      SET transaction_type_tmp = CASE transaction_type
        WHEN 'income' THEN 0
        WHEN 'expense' THEN 1
        ELSE 0
      END
    SQL

    # 3 - Remove the old column containing "string" values and rename the temporary one to match the old column name.
    remove_column :transactions, :transaction_type
    rename_column :transactions, :transaction_type_tmp, :transaction_type
  end

  def down
    # 1 - Add back the old "string" column.
    add_column :transactions, :transaction_type_tmp, :string

    # 2 - Map back all the "integer" values to "string" values.
    execute <<-SQL
      UPDATE transactions
      SET transaction_type_tmp = CASE transaction_type
        WHEN 0 THEN 'income'
        WHEN 1 THEN 'expense'
        ELSE 'income'
      END
    SQL

    # 3 - Replace the current column.
    remove_column :transactions, :transaction_type
    rename_column :transactions, :transaction_type_tmp, :transaction_type
  end
end
