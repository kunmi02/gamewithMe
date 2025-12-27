class GamesController < ApplicationController
  def index
    @games = Game.includes(:users).all
  end
end
