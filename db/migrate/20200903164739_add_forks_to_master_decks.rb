class AddForksToMasterDecks < ActiveRecord::Migration[6.0]
  def change
    add_column :master_decks, :forked_from, :integer
    add_column :master_decks, :forked_from_branch, :integer
    add_column :master_decks, :forked_from_deck, :integer
  end
end
