FactoryBot.define do
  factory :worker do
    worker_login_id       { "A#{Faker::Lorem.characters(number: 11, min_alpha: 1, min_numeric: 1)}" }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name            { Gimei.last.kanji }
    last_name             { Gimei.first.kanji }
    first_name_kana       { Gimei.last.katakana }
    last_name_kana        { Gimei.first.katakana }
    email                 { Faker::Internet.free_email }
    gender                { [true,false].sample }
    character_id          { Faker::Number.between(from: 1, to: 3) }
    position_id           { Faker::Number.between(from: 1, to: 3) }
    born                 { Faker::Date.birthday(min_age: 5, max_age: 90) }

    association :company

    after(:build) do | worker |
      worker.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
