class RemoveTitleFromHistories < ActiveRecord::Migration[6.0]
  def change
    remove_column :histories, :title, :string
  end
end
