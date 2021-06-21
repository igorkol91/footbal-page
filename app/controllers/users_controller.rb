class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @followings = @user.followers
    @followed = @user.followeds
    @followers = User.find(@followings.map{|f| f.follower_id}.uniq)
    @followeds = User.find(@followed.map{|f| f.followed_id}.uniq)
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
        format.html { redirect_to login_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def follow
    @user = User.find(params[:id])
    @follow = current_user.followeds.build(followed: @user)

    if @follow.save
      flash[:notice] = 'You are following ', @user.username
      redirect_to user_path(@user)
    else
      flash[:alert] = 'Something went wrong with your following...'
      redirect_to user_path(@user)
    end
  end

  def unfollow
    @user = User.find(params[:id])
    if Following.exists?(follower_id: current_user.id, followed_id: @user.id)
      Following.find_by('follower_id = ? and followed_id = ?', current_user.id, @user.id).destroy
      flash[:alert] = 'Unfollowed ', @user.username
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
