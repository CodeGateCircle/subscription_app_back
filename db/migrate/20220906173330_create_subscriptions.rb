class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string  :name, null: false
      t.integer :price, null: false, default: 0
      t.date    :first_payment_date, null: true
      t.text    :remarks, null: true
      t.boolean :is_paused, default: false
      t.string  :image_url
      t.integer :payment_cycle, limit:1, null: false
      t.integer :payment_method, limit:1, null: false

      t.references  :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
