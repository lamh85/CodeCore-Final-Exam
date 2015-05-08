class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: {message: "First name is missing"}
  validates :last_name, presence: {message: "Last name is missing"}

  has_many :auctions, dependent: :destroy
  has_many :bids, dependent: :destroy


  def name_display
    if first_name || last_name
      "#{first_name} #{last_name}".strip.squeeze(" ")
    else
      email
    end
  end
end
