# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 13.times do |g|
#   Game.create(name: "Game ##{g}")
#   26.times do |t|
#     Team.create(name: "Team ##{t}")
#   end
# end
26.times do |t|
  t += 1
  game = t.odd? ? Game.create!(name: "Game ##{t / 2 + 1}") : Game.find(t / 2)
  game.teams.create!(name: "Team ##{t}")
end
