class AddSlugToMasterDecks < ActiveRecord::Migration[6.0]
  def change
    add_column :master_decks, :slug, :string
    add_index :master_decks, :slug
  end
end
