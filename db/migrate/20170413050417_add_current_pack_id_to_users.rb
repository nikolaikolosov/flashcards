class AddCurrentPackIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :current_pack_id, :integer
  end
end
