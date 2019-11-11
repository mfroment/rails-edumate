class BookingsController < ApplicationController
  def create
    @user = current_user
    @lesson = Lesson.find(params[:id])
    @booking = Booking.new(booking_params)
    @booking.lesson = @lesson
    @booking.save!
    if current_user
      redirect_to user_path(@user)
    else
      redirect_to new_user_session_path
    end
  end

  private

  def lesson_params
  end
end
