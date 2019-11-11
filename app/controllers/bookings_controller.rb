class BookingsController < ApplicationController
  def create
    raise
    @user = current_user
    @lesson = Lesson.find(params[:id])
    @booking = Booking.new(booking_params)
    @booking.lesson = @lesson
    if current_user
      @booking.save!
      redirect_to user_path(@user)
    else
      redirect_to new_user_session_path
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :lesson_id)
  end
end
