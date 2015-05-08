FactoryGirl.define do
  factory :auction do
    # Create a auction that is associate with a user
    # If there is no user, then let the factory create it
    association :user, factory: :user
    association :bid, factory: :bid
    title Faker::Company.bs
    details Faker::Lorem.paragraph
    price 500
    current_price 5
  end

end
