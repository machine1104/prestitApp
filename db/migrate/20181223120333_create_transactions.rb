class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :description
      t.float :amount
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :transactions, [:user_id, :created_at]
  end
end
