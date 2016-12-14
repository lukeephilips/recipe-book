class FixListsAgain < ActiveRecord::Migration[5.0]
  def change
    rename_table :list, :lists
  end
end
