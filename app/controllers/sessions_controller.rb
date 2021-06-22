class SessionsController < ApplicationController
  def new
    redirect_to tweets_path if logged_in?
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      session[:user_id] = @user.id
      flash[:success] = "You're logged in!"
      redirect_to tweets_path
    else
      flash[:error] = 'This user does not exists!!'
      redirect_to login_path
    end
  end

  def destroy
    if logged_in?
      session.delete(:user_id)
      flash[:success] = 'You have successfully logged out.'
    end
    redirect_to login_path
  end
end
