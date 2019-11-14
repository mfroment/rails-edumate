class LessonsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_lesson, only: %i[edit update]

  def index
    if params[:query].present?
      sql_query = " \
        lessons.title @@ :query \
        OR lessons.location @@ :query \
        OR lessons.topic @@ :query \
        OR users.first_name @@ :query \
        OR users.last_name @@ :query \
        "
      @lessons = Lesson.joins(:user).where(sql_query, query: "%#{params[:query]}%").sort_by { |lesson| lesson.time }
    else
      @lessons = Lesson.all.sort_by { |lesson| lesson.time }
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

  def new
    if user_signed_in?
      @user = current_user
      @lesson = Lesson.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    if user_signed_in?
      @lesson = Lesson.new(lesson_params)
      @user = current_user
      @lesson.user = @user
      if @lesson.save
        redirect_to lesson_path(@lesson)
      else
        render 'new'
      end
    else
      # TODO: redirect to lesson page after login if possible :)
      redirect_to new_user_session_path
    end
  end

  def edit
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to lesson_path(@lesson)
    else
      render :edit
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :topic, :location, :photo, :description, :time)
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end
end
