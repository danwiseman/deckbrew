# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(username: 'bob.dole', password: 'password', email: 'test@test.nothing')
user.user_profile.update(twitter: Faker::Twitter.screen_name, tagline: Faker::ChuckNorris.fact)

master_deck = MasterDeck.create(user: user, name: Faker::Book.title, deck_type: 'commander', is_public: true, description: Faker::Coffee.notes)
master_deck.branches.create(name: 'main', source_branch: 0, source_deck: 0)
master_deck.branches.last.decks.create(version: 0, previousversion: 0)
master_deck.branches.last.update(head_deck: master_deck.branches.last.decks.last.id)