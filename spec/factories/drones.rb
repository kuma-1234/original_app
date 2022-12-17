FactoryBot.define do 
  factory :drone do
    drone_name{ "A" }
  end
  factory :drone2, class: Drone do
    drone_name{ "B" }
  end
  factory :drone3, class: Drone do
    drone_name{ "C" }
  end
end