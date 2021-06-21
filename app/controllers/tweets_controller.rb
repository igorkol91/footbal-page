class TweetsController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :set_tweet, only: %i[ show edit update destroy ]

  # GET /tweets or /tweets.json
  def index
    @tweets = Tweet.order('created_at DESC')
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
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
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
      params.require(:tweet).permit(:author_id, :text)
    end
end