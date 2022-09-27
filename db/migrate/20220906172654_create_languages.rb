class CreateLanguages < ActiveRecord::Migration[7.0]
  def change
    create_table :languages do |t|
      t.string  :language, null: false

      t.timestamps
    end
    add_index :languages, :language, unique: true
  end
end
