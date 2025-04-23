class CreateTransactionTags < ActiveRecord::Migration[8.0]
  def change
    create_table :transaction_tags do |t|
      t.references :trx, null: false, foreign_key: { to_table: :transactions }
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
