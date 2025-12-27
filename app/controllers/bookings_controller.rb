class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :update, :confirm, :cancel, :complete]
  
  def index
    # For now, show all bookings. Later we'll filter by current_user
    @upcoming_bookings = Booking.upcoming.includes(:user, :gamer, :game)
    @past_bookings = Booking.past.includes(:user, :gamer, :game).limit(10)
  end

  def new
    @booking = Booking.new
    @gamer = User.find(params[:gamer_id]) if params[:gamer_id]
    @games = Game.all
  end

  def create
    @booking = Booking.new(booking_params)
    # For now, we'll use the first user. Later this will be current_user
    @booking.user_id = User.first.id unless @booking.user_id
    
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
