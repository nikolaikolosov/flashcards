class AddPackIdToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :pack_id, :integer
  end
end
