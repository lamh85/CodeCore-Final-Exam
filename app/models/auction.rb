class Auction < ActiveRecord::Base

  include AASM

  belongs_to :user

  has_many :bids, dependent: :destroy
  belongs_to :user

  validates :title, presence: {message: "You must enter a title"}

  validates :details, presence: {message: "You must enter details"}

  validates :price, presence: {message: "You must enter a reserve price"}

  validates :ends_on, presence: {message: "You must enter a date"}

  # AASM

  aasm do
    state :published
    state :reserve_met
    state :won
    state :canceled
    state :reserve_not_met

    event :reserved do
      transitions from: :published, to: :reserve_met
    end

  end
end
