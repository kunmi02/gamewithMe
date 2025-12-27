# GameWithMe.com 🎮

A Calendly-inspired platform for booking gaming sessions with players around the world. Find your next FIFA opponent, Fortnite squad, or Call of Duty teammate!

## Features

### Core MVP Features
- **User Profiles**: Gaming handles (PSN, Xbox, Steam, Epic), bio, timezone
- **Game Library**: Browse popular games and see who plays them
- **Booking System**: Schedule gaming sessions with other players
- **Session Management**: View upcoming and past sessions
- **Status Tracking**: Pending, confirmed, cancelled, and completed bookings

### Tech Stack
- **Backend**: Ruby on Rails 8.1
- **Database**: PostgreSQL
- **Frontend**: ERB templates with TailwindCSS
- **Styling**: Modern gradient design with glassmorphism effects

## Prerequisites

- Ruby 2.6+ (recommended 3.0+)
- Rails 8.1
- PostgreSQL
- Node.js (for asset compilation)

## Getting Started

### 1. Clone the Repository
```bash
cd /path/to/your/projects
# (Project already created)
```

### 2. Install Dependencies
```bash
bundle install
```

### 3. Database Setup
```bash
# Create the database
rails db:create

# Run migrations
rails db:migrate

# Seed with sample data
rails db:seed
```

### 4. Start the Server
```bash
./bin/dev
```

The application will be available at `http://localhost:3000`

## Sample Data

The seed file creates:
- **6 sample users** with different gaming profiles
- **12 popular games** (FIFA, Fortnite, Valorant, etc.)
- **Sample bookings** to demonstrate the booking system

### Sample User Credentials
- ProGamer_Mike (mike@example.com) - FIFA expert
- SarahPlays (sarah@example.com) - Fortnite/Apex player
- TechNinja (tech@example.com) - Valorant/CS2 enthusiast
- RocketMaster (rocket@example.com) - Rocket League diamond
- CasualGamer_Alex (alex@example.com) - Casual gamer
- EsportsChamp (champ@example.com) - Former semi-pro

## Project Structure

```
app/
├── models/
│   ├── user.rb           # User profiles with gaming handles
│   ├── game.rb           # Games catalog
│   ├── booking.rb        # Gaming session bookings
│   ├── user_game.rb      # User-game associations with skill levels
│   └── availability.rb   # User availability schedules
├── controllers/
│   ├── home_controller.rb      # Landing page
│   ├── users_controller.rb     # User profiles
│   ├── bookings_controller.rb  # Booking management
│   └── games_controller.rb     # Games catalog
└── views/
    ├── home/
    ├── users/
    ├── bookings/
    └── games/
```

## Database Schema

### Users
- username, email, bio, timezone
- Gaming handles: psn_handle, xbox_handle, steam_handle, epic_handle

### Games
- name, platform, image_url

### Bookings
- user_id (booker), gamer_id (player being booked)
- game_id, start_time, end_time
- status (pending, confirmed, cancelled, completed)
- notes

### UserGames
- user_id, game_id, skill_level

### Availabilities
- user_id, start_time, end_time
- day_of_week, recurring

## Key Features to Implement Next

### Phase 2 (Authentication & Authorization)
- [ ] Add Devise or custom authentication
- [ ] User registration and login
- [ ] Session management
- [ ] Profile ownership validation

### Phase 3 (Enhanced Booking)
- [ ] Calendar view for availability
- [ ] Recurring availability slots
- [ ] Email notifications for bookings
- [ ] Booking approval workflow
- [ ] Conflict detection

### Phase 4 (Social Features)
- [ ] User ratings and reviews
- [ ] Friend system
- [ ] Session history with stats
- [ ] Search and filter gamers
- [ ] Game-specific filters

### Phase 5 (Monetization)
- [ ] Paid coaching sessions
- [ ] Premium user tiers
- [ ] Stripe integration
- [ ] Transaction fees

## Development Commands

```bash
# Run migrations
rails db:migrate

# Rollback migration
rails db:rollback

# Reset database
rails db:reset

# Open Rails console
rails console

# Run tests
rails test

# Check routes
rails routes
```

## Contributing

This is a prototype/MVP. Future enhancements welcome!

## License

MIT License

---

**Built with ❤️ for gamers who want to connect and play together**
