FactoryBot.define do
  factory :property_owner_utility_equipment_facility do
    
    name{"#{Gimei.last.kanji}ビル"}
    name_kana{"#{Gimei.last.katakana}ビル"}
    post_code{"#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}"}
    prefecture_id{Faker::Number.between(from: 1, to: 47)}
    city{"#{Gimei.address.city.kanji}#{Gimei.address.town.kanji}"}
    street{"#{Faker::Number.between(from: 1, to: 10)}-#{Faker::Number.between(from: 1, to: 10)}"}
    type_id{Faker::Number.between(from: 1, to: 3)}
    units{Faker::Number.between(from: 1, to: 3000)}
    management_form_id{Faker::Number.between(from: 1, to: 7)}
    image{File.open("#{Rails.root}/public/images/test_image.png")}
    rank_id{Faker::Number.between(from: 1, to: 4)}
    caution{"#{name}は#{["綺麗な","少し古い"].sample}建物です。"}
    #utility部分
    water_supply_id{Faker::Number.between(from: 1, to: 2)}
    sewer_id{Faker::Number.between(from: 1, to: 2)}
    electrical_id{Faker::Number.between(from: 1, to: 3)}
    ga_id{Faker::Number.between(from: 1, to: 3)}

    trait :owner_swicth_is_true do
      swicth_owner_form{true}
      last_name{ Gimei.last.kanji }
      first_name{ Gimei.first.kanji }
      last_name_kana{ Gimei.last.katakana }
      first_name_kana{ Gimei.first.katakana }
      gender{[true,false].sample}
      character_id{Faker::Number.between(from: 1, to: 3)}
      character_about{"#{last_name}さんは、優しい方です"}
      main_communication{"本人"}
      w_company_name{"テスト株式会社"}
      w_company_name_kana{"テストカブシイガイシャ"}
      w_post_code{"#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}"}
      w_prefecture_id{Faker::Number.between(from: 1, to: 47)}
      w_city{"#{Gimei.address.city.kanji}#{Gimei.address.town.kanji}"}
      w_street{"#{Faker::Number.between(from: 1, to: 10)}-#{Faker::Number.between(from: 1, to: 10)}"}
      w_building_name{"テストビル101"}
      w_company_phone_num{"000-0000-0000"}
      w_job_description{"教育事業"}
    end
    trait :owner_swicth_is_false do
      swicth_owner_form{false}
      owner_company_name{ Gimei.last.kanji+"不動産株式会社" }
      owner_company_name_kana{"#{Gimei.last.katakana}フドウサンカブシキガイシャ"}
      character_about{"#{owner_company_name}様は、有名な会社です"}
      main_communication{"営業部門の田中様"}
    end
    owner_post_code{"#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}"}
    owner_prefecture_id{Faker::Number.between(from: 1, to: 47)}
    owner_city{"#{Gimei.address.city.kanji}#{Gimei.address.town.kanji}"}
    owner_street{"#{Faker::Number.between(from: 1, to: 10)}-#{Faker::Number.between(from: 1, to: 10)}"}
    owner_building_name{"アクセルビル101"}
    communication_about{"主に電話"}
    home_phone_num{"000-0000-0000"}
    phone_num{"000-0000-0000"}
    other_phone_num{"000-0000-0000"}
    fax_num{"000-0000-0000"}
    email{"test@com"}
  end
end
