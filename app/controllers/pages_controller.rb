class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
    @lessons = Lesson.all.sort_by { |lesson| lesson.time }
  end

end
