# rubocop:disable Style/GuardClause, Style/SymbolProc
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @my_tweets = @user.tweets.includes([:author])
    @followings = @user.followers
    @followed = @user.followeds
    @followers = User.find(@followings.map { |f| f.follower_id }.uniq)
    @followeds = User.find(@followed.map { |f| f.followed_id }.uniq)
  end

  # GET /users/new
  def new
    redirect_to tweets_path if logged_in?
    @user = User.new
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: 'User was successfully created.' }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def follow
    @user = User.find(params[:id])
    @follow = current_user.followeds.build(followed: @user)

    if @follow.save
      flash[:notice] = "You are following #{@user.username}"
    else
      flash[:alert] = 'Something went wrong with your following...'
    end
    redirect_to user_path(@user)
  end

  def unfollow
    @user = User.find(params[:id])
    if Following.exists?(follower_id: current_user.id, followed_id: @user.id)
      Following.find_by('follower_id = ? and followed_id = ?', current_user.id, @user.id).destroy
      flash[:notice] = "You just unfollowed #{@user.username}"
      redirect_to user_path(@user.id)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :username, :photo, :cover)
  end
end
# rubocop:enable Style/GuardClause, Style/SymbolProc
