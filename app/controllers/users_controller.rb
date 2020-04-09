class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), :notice =>"Profile successfully updated"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :photo)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
