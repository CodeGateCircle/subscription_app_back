class ChangeDatatypePriceOfSubscriptions < ActiveRecord::Migration[7.0]
  def up
    change_column :subscriptions, :price, :decimal, precision: 8, scale: 3, default: 0
  end

  # 変更前の内容
  def down
    change_column :subscriptions, :price, :integer, default: 0
  end
end
