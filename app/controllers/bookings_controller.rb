class BookingsController < ApplicationController
  skip_before_action :authenticate_account!, only: [:index, :show]
  before_action :set_booking, only: [:show, :update, :confirm, :cancel, :complete]
  
  def index
    # Show only current user's bookings if logged in, otherwise all
    if account_signed_in?
      @upcoming_bookings = current_user_profile.all_bookings.upcoming.includes(:user, :gamer, :game)
      @past_bookings = current_user_profile.all_bookings.past.includes(:user, :gamer, :game).limit(10)
    else
      @upcoming_bookings = Booking.upcoming.includes(:user, :gamer, :game)
      @past_bookings = Booking.past.includes(:user, :gamer, :game).limit(10)
    end
  end

  def new
    @booking = Booking.new
    @gamer = User.find(params[:gamer_id]) if params[:gamer_id]
    @games = Game.all
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user_profile
    
    # Prevent self-booking
    if @booking.user_id == @booking.gamer_id
      redirect_to user_path(@booking.gamer), alert: "You cannot book a session with yourself"
      return
    end
    
    if @booking.save
      redirect_to @booking, notice: 'Booking request sent successfully!'
    else
      @games = Game.all
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: 'Booking updated successfully!'
    else
      render :show, status: :unprocessable_entity
    end
  end
  
  def confirm
    @booking.update(status: 'confirmed')
    redirect_to @booking, notice: 'Booking confirmed!'
  end
  
  def cancel
    @booking.update(status: 'cancelled')
    redirect_to @booking, notice: 'Booking cancelled.'
  end
  
  def complete
    @booking.update(status: 'completed')
    redirect_to @booking, notice: 'Booking marked as completed!'
  end

  private

  def set_booking
    @booking = Booking.includes(:user, :gamer, :game).find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:gamer_id, :game_id, :start_time, :end_time, :notes)
  end
end
