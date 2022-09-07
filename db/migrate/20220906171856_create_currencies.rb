class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string  :currency, null: false

      t.timestamps
    end
    add_index :currencies, :currency, unique: true
  end
end
