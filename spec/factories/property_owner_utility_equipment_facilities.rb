FactoryBot.define do
  factory :property_owner_utility_equipment_facility do
    
# コメントアウトされている内容は任意の情報になります。

    #property部分
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

    #utility部分
    water_supply_id{Faker::Number.between(from: 1, to: 2)}
    sewer_id{Faker::Number.between(from: 1, to: 2)}
    electrical_id{Faker::Number.between(from: 1, to: 3)}
    ga_id{Faker::Number.between(from: 1, to: 3)}

      # 以下、必須ではない任意の値 🔻
    # caution{"#{name}は#{["綺麗な","少し古い"].sample}建物です。"}

    # 個人の個別情報部分
    trait :owner_swicth_is_human do
      swicth_owner_form{"H"}
      last_name{ Gimei.last.kanji }
      first_name{ Gimei.first.kanji }
      last_name_kana{ Gimei.last.katakana }
      first_name_kana{ Gimei.first.katakana }
      main_communication{"本人"}
    end
    
    # 法人の個情報部分 
    trait :owner_swicth_is_company do
      swicth_owner_form{"C"}
      owner_company_name{ Gimei.last.kanji+"不動産株式会社" }
      owner_company_name_kana{"#{Gimei.last.katakana}フドウサンカブシキガイシャ"}
      main_communication{"営業部門の田中様"}

      # セレクトボックスはnilとして認識される為、初期値として0を置く。
      # ※法人をした場合に、0以外の値を受け付けない為。
      character_id{0}
    end
    owner_post_code{"#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}"}
    owner_prefecture_id{Faker::Number.between(from: 1, to: 47)}
    owner_city{"#{Gimei.address.city.kanji}#{Gimei.address.town.kanji}"}
    owner_street{"#{Faker::Number.between(from: 1, to: 10)}-#{Faker::Number.between(from: 1, to: 10)}"}
    communication_about{"主に電話"}
  end
end
