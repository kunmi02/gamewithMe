class GamesController < ApplicationController
  skip_before_action :authenticate_account!
  
  def index
    @games = Game.includes(:users).all
  end
end
