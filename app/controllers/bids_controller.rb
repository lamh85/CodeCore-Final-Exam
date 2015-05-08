class BidsController < ApplicationController

  before_action :validate_bid_price, only: [:create]
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @bids = current_user.bids.order(id: :desc)
  end

  def validate_bid_price
    @bid = current_user.bids.create(bid_params)
    @auction = Auction.find params[:auction_id]
    @bid.auction = @auction
    # respond_to do |format|
    if @bid.price < @auction.current_price
      redirect_to auction_path(@auction)
      flash[:alert] = "Your bid price must be higher than the current price. Could not create your bid."
      @bid.delete
    end # if less than price
    # end # respond_to
  end

  # CREATE
  def create
    respond_to do |format|
      if @bid.save
        @auction.current_price = @auction.bids.order(:price).last.price + 1
        if @auction.current_price >= @auction.price
          @auction.reserved
        end
        @auction.save        
        format.html { redirect_to auction_path(@auction), notice: "You have successfully bidded on this auction!"}
        format.js { render "create_success"}
      else
        format.html { render @auction, alert: "Could not create your bid"  }
        format.js { render "create_failure" }
      end # if save
    end # respond_to
  end # create action

  # READ
  def index
    @bids = current_user.bids
  end

  # PRIVATE
  private

  def bid_params
    params.require(:bid).permit(:user_id, :auction_id, :price)
  end  
end
