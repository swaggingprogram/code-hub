class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :concept, null: false
      t.references   :user, null: false, foreign_key: true
      t.references   :code, null: false, foreign_key: true
      t.timestamps
    end
  end
end
