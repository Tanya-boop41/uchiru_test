FactoryBot.define do
  factory :student do
    first_name { "John" }
    last_name  { "Doe" }
    surname    { "Smith" }
    association :school
    association :classroom
  end
end
