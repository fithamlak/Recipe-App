class RenameConfirmedToConfirmedAtInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :confirmed?, :confirmed_at
  end
end

