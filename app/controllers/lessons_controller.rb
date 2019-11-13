class LessonsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @search = params["search"]
    if @search.present?
      @query = @search["query"]
      if @query == ""
        @lessons = Lesson.all
      else
        @lessons = Lesson.search(@query)
      end
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
  end
end
