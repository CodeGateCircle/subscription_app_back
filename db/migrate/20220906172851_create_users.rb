class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer  :currency, limit:1, null: false,
      t.integer  :language, limit:1, null: false,

      t.timestamps
    end
  end
end
