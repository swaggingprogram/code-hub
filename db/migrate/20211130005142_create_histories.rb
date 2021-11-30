class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.references   :user, null: false, foreign_key: true
      t.references   :code, null: false, foreign_key: true
      t.timestamps
    end
  end
end
