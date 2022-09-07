class CreateSubscriptionImages < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_images do |t|
      t.string  :subscription_name, null: false
      t.binary  :subscription_image, null: false

      t.timestamps
    end
  end
end
