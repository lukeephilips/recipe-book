class AddInstructionTable < ActiveRecord::Migration[5.0]
  def change
    create_table(:instructions) do |t|
      t.column(:recipe_id, :integer)
      t.column(:step, :integer)
      t.column(:description, :string)
    end
  end
end
