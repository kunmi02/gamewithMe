class UsersController < ApplicationController
  skip_before_action :authenticate_account!, only: [:index, :show]
  before_action :set_user, except: [:index]
  before_action :authorize_user, only: [:edit, :update]
  
  def index
    @users = User.includes(:games).all
  end
  
  def show
    @user_games = @user.user_games.includes(:game)
    @upcoming_bookings = @user.upcoming_bookings.limit(5)
  end
  
  def calendar
    @availabilities = @user.availabilities
    @bookings = @user.all_bookings.where("start_time >= ?", 1.month.ago)
  end

  def edit
    @games = Game.all
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile updated successfully!'
    else
      @games = Game.all
      render :edit, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_user
    @user = User.includes(:games).find(params[:id])
  end
  
  def authorize_user
    unless @user == current_user_profile
      redirect_to root_path, alert: "You can only edit your own profile"
    end
  end
  
  def user_params
    params.require(:user).permit(
      :username, :email, :bio, :timezone,
      :psn_handle, :xbox_handle, :steam_handle, :epic_handle
    )
  end
end
