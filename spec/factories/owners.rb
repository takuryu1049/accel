# == Schema Information
#
# Table name: owners
#
#  id                  :bigint           not null, primary key
#  building_name       :string(255)
#  character_about     :text(65535)
#  city                :string(255)      not null
#  communication_about :text(65535)      not null
#  company_name        :string(255)
#  company_name_kana   :string(255)
#  email               :string(255)
#  fax_num             :string(255)
#  first_name          :string(255)
#  first_name_kana     :string(255)
#  gender              :string(255)      default("M")
#  home_phone_num      :string(255)
#  last_name           :string(255)
#  last_name_kana      :string(255)
#  main_communication  :string(255)      not null
#  other_phone_num     :string(255)
#  phone_num           :string(255)
#  post_code           :string(255)      not null
#  street              :string(255)      not null
#  swicth_owner_form   :string(255)      default("H"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  character_id        :integer
#  prefecture_id       :integer          not null
#
FactoryBot.define do
  factory :owner do
    
    # 個人の情報を生成する場合のtrait(特性)
    trait :owner_swicth_is_human do
      swicth_owner_form{"H"}
      last_name{ Gimei.last.kanji }
      first_name{ Gimei.first.kanji }
      last_name_kana{ Gimei.last.katakana }
      first_name_kana{ Gimei.first.katakana }
      main_communication{"本人"}
    end
    
    # 法人の情報を生成する場合のtrait(特性)
    trait :owner_swicth_is_company do
      swicth_owner_form{"C"}
      company_name{ Gimei.last.kanji+"不動産株式会社" }
      company_name_kana{"#{Gimei.last.katakana}フドウサンカブシキガイシャ"}
      main_communication{"営業部門の田中様"}
    end

    post_code{"#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}"}
    prefecture_id{Faker::Number.between(from: 1, to: 47)}
    city{"#{Gimei.address.city.kanji}#{Gimei.address.town.kanji}"}
    street{"#{Faker::Number.between(from: 1, to: 10)}-#{Faker::Number.between(from: 1, to: 10)}"}
    communication_about{"主に電話"}

  end
end
