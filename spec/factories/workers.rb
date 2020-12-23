# == Schema Information
#
# Table name: workers
#
#  id                     :bigint           not null, primary key
#  born                   :date             not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)      not null
#  first_name_kana        :string(255)      not null
#  gender                 :boolean          default(FALSE), not null
#  last_name              :string(255)      not null
#  last_name_kana         :string(255)      not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  character_id           :integer          not null
#  company_id             :bigint           not null
#  position_id            :integer          not null
#  qualification_id       :integer
#  worker_login_id        :string(255)      not null
#
# Indexes
#
#  index_workers_on_company_id            (company_id)
#  index_workers_on_email                 (email) UNIQUE
#  index_workers_on_reset_password_token  (reset_password_token) UNIQUE
#  index_workers_on_worker_login_id       (worker_login_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
FactoryBot.define do
  factory :worker do
    worker_login_id       { "A#{Faker::Lorem.characters(number: 11, min_alpha: 1, min_numeric: 1)}" }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name            { Gimei.first.kanji }
    last_name             { Gimei.last.kanji }
    first_name_kana       { Gimei.first.katakana }
    last_name_kana        { Gimei.last.katakana }
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
