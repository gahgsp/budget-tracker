class UpdateUserForAuthentication < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :email, :string

    add_column :users, :email_address, :string, null: false
    add_column :users, :password_digest, :string, null: false

    add_index :users, :email_address, unique: true
  end
end
