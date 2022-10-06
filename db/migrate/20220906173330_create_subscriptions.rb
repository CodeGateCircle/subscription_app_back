class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string  :name, null: false
      t.integer :price, null: false, default: 0
      t.date    :first_payment_date, null: true
      t.text    :remarks, null: true
      t.boolean :is_paused, default: false

      t.references  :user, null: false, foreign_key: true
      t.references  :subscription_image, null: false, foreign_key: true
      t.references  :payment_cycle, null: false, foreign_key: true
      t.references  :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
