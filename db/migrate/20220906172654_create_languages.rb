class CreateLanguages < ActiveRecord::Migration[7.0]
  def change
    createTable :languages do |t|
      t.string  :language, null: false

      t.timestamps
    end
    addIndex :languages, :language, unique: true
  end
end
