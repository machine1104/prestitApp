class AddTypeToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :type, :boolean
  end
end
