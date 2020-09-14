class CreateDecks < ActiveRecord::Migration[6.0]
  def change
    create_table :decks do |t|
      
      t.belongs_to :branch, null: false, foreign_key: true
      
      t.integer :version
      t.integer :previousversion
      
      t.jsonb :cards, null: false, default: ''

      t.timestamps
    end
  end
end
