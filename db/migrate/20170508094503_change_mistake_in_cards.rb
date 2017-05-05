class ChangeMistakeInCards < ActiveRecord::Migration[5.0]
  def change
    change_column :cards, :mistake, :integer, default: 0
  end
end
