class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    createTable :users do |t|
      t.references  :currency, null: false, foreignKey: true
      t.references  :language, null: false, foreignKey: true

      t.timestamps
    end
  end
end
