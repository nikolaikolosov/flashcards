class AddSuperMemoColumnsToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :interval, :integer
    add_column :cards, :efactor, :float, null: false, default: 2.5
  end
end
