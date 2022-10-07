class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string  :name,               null: false
      t.integer :price,              null: false, default: 0
      t.date    :first_payment_date, null: true
      t.text    :remarks,            null: true
      t.boolean :is_paused,          null: false, default: false
      t.string  :image_url
      t.integer :payment_cycle,      null: false, limit:1
      t.integer :payment_method,     null: false, limit:1

      t.references  :user, type: :string, null: false
      t.timestamps
    end
    add_foreign_key :subscriptions, :users, column: :user_id, primary_key: :user_id
  end
end
