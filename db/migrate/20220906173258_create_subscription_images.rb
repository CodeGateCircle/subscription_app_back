class CreateSubscriptionImages < ActiveRecord::Migration[7.0]
  def change
    createTable :subscriptionImages do |t|
      t.string  :subscriptionName, null: false
      t.binary  :subscriptionImage, null: false

      t.timestamps
    end
  end
end
