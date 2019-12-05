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

  def upcoming_events
    self.attended_events.upcoming(current_user.id, event.id)
  end

  def previous_events
    self.attended_events.past
  end

  def attending?(event)
  event.attendees.include?(self)
  end

  def attend!(event)
    self.event_attendees.create!(attended_event_id: event.id)
  end

  def cancel!(event)
    self.event_attendees.find_by(attended_event_id: event.id).destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
