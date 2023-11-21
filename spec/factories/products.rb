FactoryBot.define do
  factory :product do
    name { "Big Ski Bag" }
    type { "Ski" }
    length { 10}
    width { 15 }
    height { 15 }
    weight { 20 }
  end
end
