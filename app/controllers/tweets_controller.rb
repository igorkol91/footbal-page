class TweetsController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :set_tweet, only: %i[show edit update destroy]

  # GET /tweets or /tweets.json
  def index
    @tweets = Tweet.order('created_at DESC').includes([:author])
    @tweet = Tweet.new
    @users_all = User.all
  end

  # GET /tweets/1 or /tweets/1.json
  def show
    @user = User.find_by(params[:author_id])
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to tweets_path, notice: 'Tweet was successfully created.' }
        format.json { render :index, status: :created, location: @tweet }
      else
        format.html { redirect_to tweets_path, notice: 'Tweet body must not be empty.' }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tweet_params
    params.require(:tweet).permit(:text)
  end
end
