class CreateBranches < ActiveRecord::Migration[6.0]
  def change
    create_table :branches do |t|
      t.string :name
      t.integer :branched_from
      t.integer :branched_from_deck
      t.integer :head_deck
      t.boolean :public
      
      t.belongs_to :master_deck, null: false, foreign_key: true
      

      t.timestamps
    end
  end
end
