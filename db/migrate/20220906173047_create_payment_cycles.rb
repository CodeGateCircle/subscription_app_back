class CreatePaymentCycles < ActiveRecord::Migration[7.0]
  def change
    createTable :paymentCycles do |t|
      t.string  :paymentCycle, null: false

      t.timestamps
    end
    add_index :paymentCycles, :paymentCycle, unique: true
  end
end
