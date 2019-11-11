class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :lessons]
  def home
  end

  def lessons
  end
end
