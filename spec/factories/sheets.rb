FactoryBot.define do
  factory :sheet do
    sequence(:email) { |n| "test#{n}@zero2hero.jp" }
    sequence(:spreadsheet_id) { |n| "#{n}" }
  end
end
