FactoryBot.define do
  factory :company do
    name                  { Gimei.last.kanji+"不動産株式会社" }
    company_login_id      { "A#{Faker::Lorem.characters(number: 11, min_alpha: 1, min_numeric: 1)}" }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    post_code             { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id         { Faker::Number.between(from: 1, to: 47) }
    city                  { "#{Gimei.address.city.kanji}#{Gimei.address.town.kanji}" }
    street                { "#{Faker::Number.between(from: 1, to: 10)}-#{Faker::Number.between(from: 1, to: 10)}"  }
    building_name         {"#{Gimei.last.kanji}アパート#{Faker::Number.number(digits: 3)}"}

    after(:build) do |company|
      company.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end