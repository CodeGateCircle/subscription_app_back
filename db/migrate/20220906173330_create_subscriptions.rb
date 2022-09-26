class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    createTable :subscriptions do |t|
      t.string  :name, null: false
      t.integer :price, null: false, default: 0
      t.date    :firstPaymentDate, null: true
      t.text    :remarks, null: true
      t.references  :user, null: false, foreignKey: true
      t.references  :subscriptionImage, null: false, foreignKey: true
      t.references  :paymentCycle, null: false, foreignKey: true
      t.references  :paymentMethod, null: false, foreignKey: true

      t.timestamps
    end
  end
end
