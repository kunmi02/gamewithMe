# GameWithMe.com - Deployment Guide 🚀

## Current Status
✅ **MVP Complete** - Running locally at http://localhost:3000

## Pre-Deployment Checklist

### 🔐 Critical: Add Authentication First
**DO NOT deploy without authentication!**

```bash
# Add Devise gem
bundle add devise

# Install Devise
rails generate devise:install
rails generate devise User

# This will require refactoring the User model
# Consider creating a separate Profile model instead
```

### 📋 Before Going Live

#### Security
- [ ] Add authentication (Devise/Sorcery)
- [ ] Add authorization (Pundit/CanCanCan)
- [ ] Enable HTTPS/SSL
- [ ] Set up environment variables
- [ ] Add rate limiting (Rack::Attack)
- [ ] Configure CORS if needed
- [ ] Review and update secrets

#### Database
- [ ] Set up production database (PostgreSQL)
- [ ] Run migrations on production
- [ ] Set up database backups
- [ ] Add database indexes for performance
- [ ] Configure connection pooling

#### Performance
- [ ] Add Redis for caching
- [ ] Optimize asset pipeline
- [ ] Enable CDN for assets
- [ ] Add pagination to lists
- [ ] Optimize database queries (N+1)
- [ ] Add background jobs (Sidekiq)

#### Monitoring
- [ ] Set up error tracking (Sentry/Rollbar)
- [ ] Add performance monitoring (New Relic/Scout)
- [ ] Configure logging
- [ ] Set up uptime monitoring
- [ ] Add analytics (Google Analytics/Plausible)

#### Email
- [ ] Configure ActionMailer
- [ ] Set up email service (SendGrid/Mailgun)
- [ ] Create email templates
- [ ] Test email delivery
- [ ] Add unsubscribe links

## Deployment Options

### Option 1: Heroku (Easiest)

```bash
# Install Heroku CLI
brew tap heroku/brew && brew install heroku

# Login
heroku login

# Create app
heroku create gamewithme

# Add PostgreSQL
heroku addons:create heroku-postgresql:mini

# Add Redis (optional)
heroku addons:create heroku-redis:mini

# Set environment variables
heroku config:set RAILS_MASTER_KEY=your_master_key

# Deploy
git push heroku main

# Run migrations
heroku run rails db:migrate

# Seed database (optional)
heroku run rails db:seed

# Open app
heroku open
```

**Cost**: ~$7-25/month for hobby tier

### Option 2: Railway (Modern, Simple)

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Initialize
railway init

# Deploy
railway up

# Add PostgreSQL
railway add

# Set environment variables in dashboard
```

**Cost**: ~$5-20/month

### Option 3: Render (Good Free Tier)

1. Connect GitHub repository
2. Create Web Service
3. Add PostgreSQL database
4. Set environment variables
5. Deploy automatically on push

**Cost**: Free tier available, paid starts at $7/month

### Option 4: DigitalOcean/AWS (Full Control)

**Requirements:**
- Ubuntu 22.04 server
- Nginx
- PostgreSQL
- Redis
- Capistrano for deployment

**Cost**: $12-50/month depending on size

## Environment Variables

Create `.env` file (don't commit!):

```bash
# Database
DATABASE_URL=postgresql://user:password@host:5432/gamewithme_production

# Rails
RAILS_ENV=production
RAILS_MASTER_KEY=your_master_key_here
SECRET_KEY_BASE=generate_with_rails_secret

# Email (SendGrid example)
SENDGRID_API_KEY=your_sendgrid_key
SMTP_ADDRESS=smtp.sendgrid.net
SMTP_USERNAME=apikey

# Redis (if using)
REDIS_URL=redis://localhost:6379/0

# Optional: OAuth
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret
DISCORD_CLIENT_ID=your_discord_client_id
DISCORD_CLIENT_SECRET=your_discord_client_secret
```

## Production Configuration

### config/environments/production.rb

Key settings to verify:

```ruby
# Force SSL
config.force_ssl = true

# Asset host (if using CDN)
config.asset_host = 'https://cdn.gamewithme.com'

# Email configuration
config.action_mailer.default_url_options = { host: 'gamewithme.com' }
config.action_mailer.delivery_method = :smtp

# Logging
config.log_level = :info

# Caching
config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }
```

## Domain Setup

### DNS Configuration

```
A     @     your_server_ip
A     www   your_server_ip
CNAME www   gamewithme.com
```

### SSL Certificate

**Option 1: Let's Encrypt (Free)**
```bash
sudo certbot --nginx -d gamewithme.com -d www.gamewithme.com
```

**Option 2: Cloudflare (Free + CDN)**
- Point DNS to Cloudflare
- Enable SSL/TLS
- Configure caching rules

## Post-Deployment

### Initial Setup
```bash
# SSH into server
ssh deploy@your_server

# Run migrations
cd /var/www/gamewithme
RAILS_ENV=production rails db:migrate

# Seed initial data (optional)
RAILS_ENV=production rails db:seed

# Precompile assets
RAILS_ENV=production rails assets:precompile

# Restart server
sudo systemctl restart puma
```

### Monitoring Commands
```bash
# Check logs
tail -f log/production.log

# Check server status
sudo systemctl status puma
sudo systemctl status nginx

# Database console
RAILS_ENV=production rails dbconsole

# Rails console
RAILS_ENV=production rails console
```

## Continuous Deployment

### GitHub Actions Example

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy to Heroku
        uses: akhileshns/heroku-deploy@v3.12.12
        with:
          heroku_api_key: ${{secrets.HEROKU_API_KEY}}
          heroku_app_name: "gamewithme"
          heroku_email: "your@email.com"
```

## Backup Strategy

### Database Backups
```bash
# Daily backup script
#!/bin/bash
DATE=$(date +%Y%m%d)
pg_dump gamewithme_production > backup_$DATE.sql
aws s3 cp backup_$DATE.sql s3://gamewithme-backups/
```

### Automated Backups
- Heroku: Automatic with paid plans
- Railway: Built-in backups
- Render: Automatic daily backups
- DigitalOcean: Set up cron job

## Performance Optimization

### Database Indexes
```ruby
# Add in migration
add_index :bookings, [:gamer_id, :start_time]
add_index :bookings, [:user_id, :start_time]
add_index :bookings, :status
add_index :user_games, [:user_id, :game_id]
```

### Caching Strategy
```ruby
# Cache expensive queries
@featured_gamers = Rails.cache.fetch('featured_gamers', expires_in: 1.hour) do
  User.includes(:games).limit(6)
end
```

### CDN Setup
- Cloudflare (Free)
- AWS CloudFront
- Fastly

## Scaling Considerations

### When to Scale
- Response time > 500ms
- Database CPU > 80%
- Memory usage > 80%
- Error rate > 1%

### Horizontal Scaling
- Add more web servers
- Use load balancer
- Separate database server
- Add Redis for sessions

### Vertical Scaling
- Upgrade server size
- Increase database resources
- Add more memory

## Cost Estimates

### Minimal Setup (Hobby)
- Heroku Hobby: $7/month
- PostgreSQL: Included
- Total: **$7/month**

### Small Business
- Render Standard: $25/month
- PostgreSQL: $7/month
- Redis: $10/month
- SendGrid: $15/month
- Total: **$57/month**

### Growing Platform
- DigitalOcean Droplet: $24/month
- Managed PostgreSQL: $15/month
- Managed Redis: $10/month
- CDN: $10/month
- Monitoring: $20/month
- Total: **$79/month**

## Launch Checklist

### Week Before Launch
- [ ] Complete authentication system
- [ ] Write tests
- [ ] Set up staging environment
- [ ] Load test the application
- [ ] Prepare marketing materials
- [ ] Set up social media accounts

### Day Before Launch
- [ ] Final code review
- [ ] Database backup
- [ ] Test all user flows
- [ ] Verify email delivery
- [ ] Check mobile responsiveness
- [ ] Prepare rollback plan

### Launch Day
- [ ] Deploy to production
- [ ] Run smoke tests
- [ ] Monitor error rates
- [ ] Watch server metrics
- [ ] Announce on social media
- [ ] Monitor user feedback

### Week After Launch
- [ ] Review analytics
- [ ] Fix critical bugs
- [ ] Gather user feedback
- [ ] Plan next features
- [ ] Optimize based on usage

## Support & Maintenance

### Daily
- Monitor error logs
- Check server health
- Review user feedback

### Weekly
- Database maintenance
- Security updates
- Performance review

### Monthly
- Backup verification
- Cost analysis
- Feature planning
- User analytics review

---

**Remember**: Don't deploy without authentication! Users need to be able to sign up and manage their own profiles and bookings.

**Next Steps**:
1. Add Devise authentication
2. Set up staging environment
3. Choose hosting provider
4. Configure domain
5. Deploy!
