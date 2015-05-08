class AuctionsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  # CREATE
  def new
    @auction = Auction.new
  end

  def create
    @auction = current_user.auctions.create(auction_params)
    @auction.current_price = 0
    if @auction.save
      flash[:notice] = "Your auction was successfully created"
      redirect_to @auction
    else
      render :new
      flash[:alert] = "Could not create your auction"
    end
  end

  # READ
  def index
    @auctions = Auction.all
  end

  def show
    @auction = Auction.find(params[:id])
    @bid = Bid.new
  end

  # PRIVATE
  private

  def auction_params
    params.require(:auction).permit(:title, :details, :price, :ends_on, :user_id)
  end

end
