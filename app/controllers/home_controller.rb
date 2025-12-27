class HomeController < ApplicationController
  skip_before_action :authenticate_account!
  
  def index
    @featured_gamers = User.includes(:games).limit(6)
    @popular_games = Game.includes(:users).limit(8)
  end
end
