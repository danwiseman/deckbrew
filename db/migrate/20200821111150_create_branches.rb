class CreateBranches < ActiveRecord::Migration[6.0]
  def change
    create_table :branches do |t|
      t.string :name
      t.integer :head_deck
      t.boolean :is_public
      
      t.jsonb :branched_from
      t.jsonb :merge_history, default: []
      
      t.belongs_to :master_deck, null: false, foreign_key: true
      

      t.timestamps
    end
  end
end
