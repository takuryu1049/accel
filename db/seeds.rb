# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

2.times do |c|
  # ランダムなデータの生成 (company)
  name = Gimei.last.kanji+"不動産株式会社"
  company_login_id = "A#{Faker::Lorem.characters(number: 11, min_alpha: 1, min_numeric: 1)}"
  email = Faker::Internet.free_email
  password = "test1111"
  password_confirmation = password
  post_code = "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}"
  prefecture_id = Faker::Number.between(from: 1, to: 47)
  city = "#{Gimei.address.city.kanji}#{Gimei.address.town.kanji}"
  street = "#{Faker::Number.between(from: 1, to: 10)}-#{Faker::Number.between(from: 1, to: 10)}"
  building_name = "#{Gimei.last.kanji}アパート#{Faker::Number.number(digits: 3)}"
  # companyの作成 (会社を30社作成します)
  company = Company.new(
    name: name,
    company_login_id: company_login_id,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    post_code: post_code,
    prefecture_id: prefecture_id,
    city: city,
    street: street,
    building_name: building_name 
  )
  company.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
  company.save
  30.times do |w|
  # ランダムなデータの生成 (worker)
    worker_login_id = "A#{Faker::Lorem.characters(number: 11, min_alpha: 1, min_numeric: 1)}"
    password = "test1111"
    password_confirmation = password
    first_name = Gimei.first.kanji
    last_name = Gimei.last.kanji
    first_name_kana = Gimei.first.katakana
    last_name_kana = Gimei.last.katakana
    email = Faker::Internet.free_email
    gender = [true,false].sample
    character_id = Faker::Number.between(from: 1, to: 3)
    position_id = Faker::Number.between(from: 1, to: 3)
    born = Faker::Date.birthday(min_age: 5, max_age: 90)
    # workerの作成 (社員を30人作成します)
    worker = Worker.new(
      worker_login_id: worker_login_id,
      password: password,
      password_confirmation: password_confirmation,
      last_name: last_name,
      first_name: first_name,
      last_name_kana: last_name_kana,
      first_name_kana: first_name_kana, 
      email: email,
      gender: gender,
      character_id: character_id,
      position_id: position_id,
      born: born,
      company_id: company.id
    )
    worker.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    worker.save!
    # ここから、物件登録のフェーズには入ります
    1.times do |p|
      # ランダムなデータの生成 (物件を30棟作成します)
      name = "#{Gimei.last.kanji}ビル"
      name_kana = "#{Gimei.last.katakana}ビル"
      post_code = "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}"
      prefecture_id = Faker::Number.between(from: 1, to: 47)
      city = "#{Gimei.address.city.kanji}#{Gimei.address.town.kanji}"
      street = "#{Faker::Number.between(from: 1, to: 10)}-#{Faker::Number.between(from: 1, to: 10)}"
      type_id = Faker::Number.between(from: 1, to: 3)
      units = Faker::Number.between(from: 1, to: 3000)
      management_form_id = Faker::Number.between(from: 1, to: 7)
      rank_id = Faker::Number.between(from: 1, to: 4)
      # ランダムなデータの生成 (物件についてのライフラインを30件作成します)
      water_supply_id = Faker::Number.between(from: 1, to: 2)
      sewer_id = Faker::Number.between(from: 1, to: 2)
      electrical_id = Faker::Number.between(from: 1, to: 3)
      ga_id = Faker::Number.between(from: 1, to: 3)
      # ランダムなデータの生成 (所有形態に応じて、所有者情報を作成します)
      swicth_owner_form = ["H","C"].sample
      if swicth_owner_form == "H"
        last_name =  Gimei.last.kanji
        first_name =  Gimei.first.kanji
        last_name_kana =  Gimei.last.katakana
        first_name_kana =  Gimei.first.katakana
        main_communication = "本人"
      else
        swicth_owner_form = "C"
        owner_company_name =  Gimei.last.kanji+"不動産株式会社" 
        owner_company_name_kana = "#{Gimei.last.katakana}フドウサンカブシキガイシャ"
        main_communication = "営業部門の田中様"
      end
      owner_post_code = "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}"
      owner_prefecture_id = Faker::Number.between(from: 1, to: 47)
      owner_city = "#{Gimei.address.city.kanji}#{Gimei.address.town.kanji}"
      owner_street = "#{Faker::Number.between(from: 1, to: 10)}-#{Faker::Number.between(from: 1, to: 10)}"
      communication_about = "主に電話"
      # ランダムなデータの生成 (所有者住所を30件作成します)
      if swicth_owner_form == "H"
        owner = Owner.create(
          swicth_owner_form: swicth_owner_form,
          last_name: last_name,
          first_name: first_name,
          last_name_kana: last_name_kana,
          first_name_kana: first_name_kana,
          company_name: "",
          company_name_kana: "",
          gender: "",
          character_id: 0,
          character_about: "",
          post_code: owner_post_code,
          prefecture_id: owner_prefecture_id,
          city: owner_city,
          street: owner_street,
          main_communication: main_communication,
          communication_about: communication_about,
          home_phone_num: "",
          phone_num: "",
          other_phone_num: "",
          fax_num: "",
          email: ""
        )
      else
        owner = Owner.create(
          swicth_owner_form: swicth_owner_form,
          last_name: "",
          first_name: "",
          last_name_kana: "",
          first_name_kana: "",
          company_name: owner_company_name,
          company_name_kana: owner_company_name_kana,
          character_about: "",
          post_code: owner_post_code,
          prefecture_id: owner_prefecture_id,
          city: owner_city,
          street: owner_street,
          main_communication: main_communication,
          communication_about: communication_about,
          home_phone_num: "",
          phone_num: "",
          other_phone_num: "",
          fax_num: "",
          email: ""
        )
      end
      property = Property.new(
        name: name,
        name_kana: name_kana,
        post_code: post_code,
        prefecture_id: prefecture_id,
        city: city,
        street: street,
        type_id: type_id,
        units: units,
        management_form_id: management_form_id,
        rank_id: rank_id ,
        company_id: company.id,
        worker_id: worker.id,
        owner_id: owner.id
      )
      property.image.attach(io: File.open("public/images/p_#{w}.jpg"), filename: "p_#{w}.jpg")
      property.save!
      utility = Utility.create(
        water_supply_id: water_supply_id,
        sewer_id: sewer_id,
        electrical_id: electrical_id,
        ga_id: ga_id,
        property_id: property.id
      )
    end
  end
end
