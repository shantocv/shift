class AddUniqIndexToMemberships < ActiveRecord::Migration[5.2]
  def change
    add_index :memberships, [:user_id, :team_id], unique: true
  end
end
