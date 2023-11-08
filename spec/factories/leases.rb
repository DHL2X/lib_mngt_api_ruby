FactoryBot.define do
  factory :lease do
    user { nil }
    book { nil }
    start_date { "2023-10-30" }
    end_date { "2023-10-30" }
  end
end
