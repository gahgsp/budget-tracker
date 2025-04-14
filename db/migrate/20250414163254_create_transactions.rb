class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.decimal :amount
      t.string :description
      t.string :transaction_type
      t.date :date

      t.timestamps
    end
  end
end
