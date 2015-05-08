require 'rails_helper'

RSpec.describe BidsController, type: :controller do


  let(:bid)   { create(:bid) }
  @auction = FactoryGirl.create(:auction)

  describe "#create" do
    context "with valid parameters" do
      def valid_request
        get @auction
        post :create, {bid: {price: 10}
      end # valid request

      it "creates a new bid in the database" do
        expect{valid_request}.to change {Bid.count}.by(1)
      end # "creates...in db"

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end # "...flash message"

      it "redirects to auction show page" do
        valid_request
        expect(response).to redirect_to(auction_path(Bid.last.auction))
      end # "...show page"

    end # "with valid..."


  end

end
