class BookingsController < ApplicationController
  def create
    @booking = Booking.new
    @user = current_user
    @lesson = Lesson.find(params[:lesson_id])
    @booking.lesson = @lesson
    @booking.user = @user
    if current_user
      if @booking.save
        redirect_to user_path(@user), :notice =>"Booking was successfully reserved"
      else
        render 'lessons/show'
      end
    else
      # TODO: redirect to lesson page after login if possible :)
      redirect_to new_user_session_path
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :lesson_id)
  end
end
