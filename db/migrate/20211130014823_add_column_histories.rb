class AddColumnHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :histories, :title, :string
  end
end
