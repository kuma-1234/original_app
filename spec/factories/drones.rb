FactoryBot.define do 
  factory :drone do
    drone_name{ "A" }
  end
  factory :drone2, class: Drone do
    drone_name{ "B" }
  end
end