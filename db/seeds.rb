# Clear existing data
puts "Cleaning database..."
Booking.destroy_all
UserGame.destroy_all
Availability.destroy_all
Game.destroy_all
User.destroy_all

# Create Games
puts "Creating games..."
games = [
  { name: "FIFA 24", platform: "PlayStation, Xbox, PC" },
  { name: "Call of Duty: Modern Warfare III", platform: "PlayStation, Xbox, PC" },
  { name: "Fortnite", platform: "PlayStation, Xbox, PC, Switch" },
  { name: "Apex Legends", platform: "PlayStation, Xbox, PC" },
  { name: "Rocket League", platform: "PlayStation, Xbox, PC, Switch" },
  { name: "Valorant", platform: "PC" },
  { name: "League of Legends", platform: "PC" },
  { name: "Counter-Strike 2", platform: "PC" },
  { name: "Overwatch 2", platform: "PlayStation, Xbox, PC, Switch" },
  { name: "Minecraft", platform: "All Platforms" },
  { name: "Grand Theft Auto V", platform: "PlayStation, Xbox, PC" },
  { name: "NBA 2K24", platform: "PlayStation, Xbox, PC, Switch" }
]

created_games = games.map do |game_data|
  Game.create!(game_data)
end

# Create Users
puts "Creating users..."
users_data = [
  {
    username: "ProGamer_Mike",
    email: "mike@example.com",
    bio: "Competitive FIFA player. Looking for challenging matches!",
    timezone: "America/New_York",
    psn_handle: "ProMike24",
    xbox_handle: "MikeTheGamer"
  },
  {
    username: "SarahPlays",
    email: "sarah@example.com",
    bio: "Casual gamer who loves Fortnite and Apex. Let's squad up!",
    timezone: "Europe/London",
    epic_handle: "SarahPlays_",
    steam_handle: "sarah_gaming"
  },
  {
    username: "TechNinja",
    email: "tech@example.com",
    bio: "Valorant and CS2 enthusiast. Always down for tactical shooters.",
    timezone: "Asia/Tokyo",
    steam_handle: "TechNinja_JP"
  },
  {
    username: "RocketMaster",
    email: "rocket@example.com",
    bio: "Diamond rank in Rocket League. Teaching and playing!",
    timezone: "America/Los_Angeles",
    psn_handle: "RocketMaster_",
    epic_handle: "RocketMaster"
  },
  {
    username: "CasualGamer_Alex",
    email: "alex@example.com",
    bio: "Just here to have fun and meet new gaming friends!",
    timezone: "America/Chicago",
    xbox_handle: "AlexGames",
    steam_handle: "casual_alex"
  },
  {
    username: "EsportsChamp",
    email: "champ@example.com",
    bio: "Former semi-pro. Now playing for fun and coaching others.",
    timezone: "Europe/Paris",
    steam_handle: "EsportsChamp",
    epic_handle: "ChampGaming"
  }
]

created_users = users_data.map do |user_data|
  User.create!(user_data)
end

# Assign games to users
puts "Assigning games to users..."
user_game_assignments = [
  { user: created_users[0], games: [0, 1, 11], skill_levels: ["expert", "advanced", "intermediate"] },
  { user: created_users[1], games: [2, 3, 4], skill_levels: ["intermediate", "intermediate", "beginner"] },
  { user: created_users[2], games: [5, 7, 3], skill_levels: ["expert", "advanced", "intermediate"] },
  { user: created_users[3], games: [4, 2, 9], skill_levels: ["expert", "intermediate", "beginner"] },
  { user: created_users[4], games: [9, 10, 2], skill_levels: ["intermediate", "beginner", "beginner"] },
  { user: created_users[5], games: [6, 5, 8], skill_levels: ["expert", "expert", "advanced"] }
]

user_game_assignments.each do |assignment|
  assignment[:games].each_with_index do |game_index, i|
    UserGame.create!(
      user: assignment[:user],
      game: created_games[game_index],
      skill_level: assignment[:skill_levels][i]
    )
  end
end

# Create some sample bookings
puts "Creating sample bookings..."
Booking.create!(
  user: created_users[0],
  gamer: created_users[1],
  game: created_games[2],
  start_time: 2.days.from_now.change(hour: 19, min: 0),
  end_time: 2.days.from_now.change(hour: 21, min: 0),
  status: "confirmed",
  notes: "Let's play some Fortnite duos!"
)

Booking.create!(
  user: created_users[2],
  gamer: created_users[3],
  game: created_games[4],
  start_time: 1.day.from_now.change(hour: 20, min: 0),
  end_time: 1.day.from_now.change(hour: 22, min: 0),
  status: "pending",
  notes: "Rocket League 2v2 ranked"
)

Booking.create!(
  user: created_users[4],
  gamer: created_users[5],
  game: created_games[6],
  start_time: 3.days.from_now.change(hour: 18, min: 0),
  end_time: 3.days.from_now.change(hour: 20, min: 0),
  status: "confirmed",
  notes: "League of Legends - Normal games for practice"
)

puts "Seed data created successfully!"
puts "#{User.count} users created"
puts "#{Game.count} games created"
puts "#{UserGame.count} user-game associations created"
puts "#{Booking.count} bookings created"
