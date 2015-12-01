FactoryGirl.define do
  factory :pharmacy do
    name "Chemical Warehouse of Doom"
  end

  factory :open_period do
    day "Monday"
    time_from "08:00"
    time_to "23:00"
  end
end
