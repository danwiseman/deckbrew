class CreateMasterDecks < ActiveRecord::Migration[6.0]
  def change
    create_table :master_decks do |t|
      t.string :name
      t.belongs_to :user, foreign_key: true
      
      t.string :type

      t.timestamps
      
    end
  end
end
