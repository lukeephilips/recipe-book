class FixListTableAgain < ActiveRecord::Migration[5.0]
  def change
    rename_table :ingredients_amounts , :lists
  end
end
