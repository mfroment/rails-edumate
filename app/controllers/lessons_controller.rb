class LessonsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    if params[:query].present?
      sql_query = " \
        lessons.title @@ :query \
        OR lessons.location @@ :query \
        OR lessons.topic @@ :query \
        OR users.first_name @@ :query \
        OR users.last_name @@ :query \
        "
      @lessons = Lesson.joins(:user).where(sql_query, query: "%#{params[:query]}%")
    else
      @lessons = Lesson.all
    end
  end

  def show
    @lesson = Lesson.geocoded.find(params[:id])
    @booking = Booking.new
    @user = current_user

    @markers = [{ lat: @lesson.latitude,
                 lng: @lesson.longitude }]

    if user_signed_in?
      @booked = !(@user.bookings.select { |booking| booking.lesson_id == @lesson.id }.empty?)
    else
      @booked = false
    end
  end
end
