class RemovePaymentMethodFromSubscriptions < ActiveRecord::Migration[7.0]
  def up
    remove_column :subscriptions, :payment_method, :integer
  end

  def down
    add_column :subscriptions, :payment_method, :integer
  end
end
