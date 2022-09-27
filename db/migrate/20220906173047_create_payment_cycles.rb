class CreatePaymentCycles < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_cycles do |t|
      t.string  :payment_cycle, null: false

      t.timestamps
    end
    add_index :payment_cycles, :payment_cycle, unique: true
  end
end
