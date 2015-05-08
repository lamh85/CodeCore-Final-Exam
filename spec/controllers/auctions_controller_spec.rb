require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do

  let(:auction)   { create(:auction) }

  describe "#create" do

    context "with valid parameters" do
      def valid_request
        post :create, {auction: {
          title: "something",
          details: "something",
          price: 100,
          ends_on: "2015-05-08",
          }}
      end

      it "creates a new auction in the database" do
        expect { valid_request }.to change {Auction.count}.by(1)
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end

      it "redirects to auction show page" do
        valid_request
        expect(response).to redirect_to(auction_path(Auction.last))
      end

    end # with valid parameters

    context "with invalid parameters" do
      def invalid_request
        post :create, auction: {title: ""}
      end

      it "doesn't create a record in the database" do
        invalid_request
        expect { invalid_request }.to change {Auction.count}.by(0)
      end

      it "renders the 'new' page" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "creates a flash message" do
        invalid_request
        expect(flash[:alert]).to be
      end

    end # with invalid parameters

  end # describe "#create"

end
