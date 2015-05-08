FactoryGirl.define do
  factory :bid do
    # Create a bid that is associate with a user
    # If there is no user, then let the factory create it
    association :user, factory: :user
    association :auction, factory: :auction
    price 10
  end

end
