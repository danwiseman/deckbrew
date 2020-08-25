class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|
      t.string :avatar
      t.jsonb :socialmedia
      t.string :tagline
      t.boolean :default_deck_visibility

      t.belongs_to :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
