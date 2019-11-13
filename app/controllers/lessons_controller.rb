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
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
    @booking = Booking.new
  end
end
