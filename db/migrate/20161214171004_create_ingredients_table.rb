class CreateIngredientsTable < ActiveRecord::Migration[5.0]
  def change
    create_table(:ingredients) do |t|
      t.column(:name, :string)
      t.column(:food_group, :string)

      t.timestamps
    end

    create_table(:recipes) do |t|
      t.column(:title, :string)
      t.column(:cook_time, :string)
      t.column(:servings, :integer)
      t.column(:rating, :integer)
      t.column(:spice, :integer)

      t.timestamps
    end

    create_table(:tags) do |t|
      t.column(:name, :string)
      t.column(:category, :string)

      t.timestamps
    end

    create_table(:ingredients_amounts) do |t|
      t.column(:amount, :integer)
      t.column(:units, :string)
      t.column(:ingredient_id, :integer)
      t.column(:recipe_id, :integer)

      t.timestamps
    end

    create_table(:recipes_tags) do |t|
      t.column(:recipe_id, :integer)
      t.column(:tag_id, :integer)

      t.timestamps
    end
  end
end
