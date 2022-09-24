FactoryBot.define do
  factory :post do
    title { "MyString" }
    start_day { "2022-09-21" }
    end_day { "2022-09-22" }
    all_day { false }
    memo { "memo" }
  end
end
