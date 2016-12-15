class ChangeUnitsToUnit < ActiveRecord::Migration[5.0]
  def change
    rename_column :lists, :units, :unit
  end
end
