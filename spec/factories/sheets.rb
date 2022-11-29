FactoryBot.define do
  factory :sheet do
    sequence(:email) { |n| "test#{n}@example.com" }
    sequence(:spreadsheet_id) { |n| "#{n}" }
  end
end
