FactoryBot.define do
  factory :classroom do
    number { 1 }
    letter { "A" }
    association :school
  end
end
