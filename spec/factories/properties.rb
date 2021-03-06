# == Schema Information
#
# Table name: properties
#
#  id                 :bigint           not null, primary key
#  caution            :text(65535)
#  city               :string(255)      not null
#  name               :string(255)      not null
#  name_kana          :string(255)      not null
#  post_code          :string(255)      not null
#  street             :string(255)      not null
#  units              :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  company_id         :bigint           not null
#  management_form_id :integer          not null
#  owner_id           :bigint           not null
#  prefecture_id      :integer          not null
#  rank_id            :integer          not null
#  type_id            :integer          not null
#  worker_id          :bigint           not null
#
# Indexes
#
#  index_properties_on_company_id  (company_id)
#  index_properties_on_owner_id    (owner_id)
#  index_properties_on_worker_id   (worker_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (owner_id => owners.id)
#  fk_rails_...  (worker_id => workers.id)
#
FactoryBot.define do
  factory :property do

    name{"#{Gimei.last.kanji}ビル"}
    name_kana{"#{Gimei.last.katakana}ビル"}
    post_code{"#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}"}
    prefecture_id{Faker::Number.between(from: 1, to: 47)}
    city{"#{Gimei.address.city.kanji}#{Gimei.address.town.kanji}"}
    street{"#{Faker::Number.between(from: 1, to: 10)}-#{Faker::Number.between(from: 1, to: 10)}"}
    type_id{Faker::Number.between(from: 1, to: 3)}
    units{Faker::Number.between(from: 1, to: 3000)}
    management_form_id{Faker::Number.between(from: 1, to: 7)}
    rank_id{Faker::Number.between(from: 1, to: 4)}
    caution{"物件の注意事項になります。"}

    after(:build) do |property|
      property.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
