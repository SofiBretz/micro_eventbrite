class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:success] = "Welcome to Micro Eventbrite!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(current_user.id)
    @events= @user.events
    @upcoming_events = @user.upcoming_events
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
