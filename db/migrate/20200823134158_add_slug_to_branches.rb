class AddSlugToBranches < ActiveRecord::Migration[6.0]
  def change
    add_column :branches, :slug, :string
    add_index :branches, :slug
  end
end
