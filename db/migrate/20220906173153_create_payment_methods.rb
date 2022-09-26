class CreatePaymentMethods < ActiveRecord::Migration[7.0]
  def change
    createTable :paymentMethods do |t|
      t.string  :paymentMethod, null: false

      t.timestamps
    end
    addIndex :paymentMethods, :paymentMethod, unique: true
  end
end
