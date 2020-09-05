class AddDeletedToBranches < ActiveRecord::Migration[6.0]
  def change
    add_column :branches, :deleted, :boolean
  end
end
