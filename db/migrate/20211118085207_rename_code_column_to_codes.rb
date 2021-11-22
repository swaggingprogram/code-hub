class RenameCodeColumnToCodes < ActiveRecord::Migration[6.0]
  def change
    rename_column :codes, :code, :codetext
  end
end
