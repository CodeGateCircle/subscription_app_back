class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    createTable :currencies do |t|
      t.string  :currency, null: false

      t.timestamps
    end
    addIndex :currencies, :currency, unique: true
  end
end
