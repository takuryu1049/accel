require 'rails_helper'

RSpec.describe "新規物件情報登録 -結合テスト", type: :system do
  # アプリのTOP画面にアクセスする為の、会社・社員情報を作成する為のインスタンスをビルドしておく。
  before do
    @worker = FactoryBot.build(:worker)
    @company = @worker.company
  end
  def stop(seconds = 0)
    sleep seconds
  end
  context '新規登録ができるとき' do #  🤚
    context '⇢ 所有形態が個人の場合' do #  🤚
      before do
        # 個人用の情報をビルドする
        @property_owner_utility_equipment_facility = FactoryBot.build(:property_owner_utility_equipment_facility, :owner_swicth_is_human)
      end
      it '正しい値を入力した場合 ⇢ 物件情報が登録でき、物件一覧画面に移動する' do
        # 🔴 【後でやる作業】ボタンがあることなどを確認する。アプリ紹介ページに行って、登録できていないことを確認する。
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        # expect(page).to have_content('新規登録')
        # # 新規登録ページへ移動する
        # visit new_user_registration_path

        # 会社アカウント登録ページへ移動する
        visit new_company_registration_path

        # 会社アカウント登録に必要な情報を入力する
        fill_in 'company_name', with: @company.name
        attach_file('company[image]', 'public/images/test_image.png', make_visible: true)
        fill_in 'company_company_login_id', with: @company.company_login_id
        fill_in 'company_email', with: @company.email
        fill_in 'company_password', with: @company.password
        fill_in 'company_password_confirmation', with: @company.password_confirmation
        fill_in 'company_post_code', with: @company.post_code
        find("#company_prefecture_id > option[value='#{rand(1...47)}']").click
        fill_in 'company_city', with: @company.city
        fill_in 'company_street', with: @company.street

        # アカウント作成ボタンを押すと会社モデルのカウント(レコード数)が1上がることを確認する。つまり、アカウントが作成されたことを確認する。
        expect{
          find(".create-account").click
        }.to change { Company.count }.by(1)

        # 登録された最新のアカウントを取得する
        latest_company = Company.order(created_at: :desc).limit(1)

        # 登録されたアカウントが入力したアカウントと同じかを確認する。
        # テストの際に理解しやすくするために作成している、後クエリパラメータにデバイスの仕様かわからないけど、パスを判定できないため生成している。
        expect(@company.company_login_id == latest_company[0].company_login_id ).to eq true

        # ログイン後社員アカウント作成ページへ遷移する事を確認する
        expect(current_path).to eq new_worker_registration_path(latest_company[0].id)

        # ログインに成功した場合のみ表示されるFlash要素が表示されていることを確認
        expect(page).to have_content("会社アカウントが登録されました！")
        
        # ここからが社員登録処理

        # 社員情報登録に必要な値を入力する
        fill_in 'worker_worker_login_id', with: @worker.worker_login_id
        fill_in 'worker_password', with: @worker.password
        fill_in 'worker_password_confirmation', with: @worker.password_confirmation
        fill_in "worker_last_name", with: @worker.last_name
        fill_in "worker_first_name", with: @worker.first_name
        fill_in "worker_last_name_kana", with: @worker.last_name_kana
        fill_in "worker_first_name_kana", with: @worker.first_name_kana
        fill_in 'worker_email', with: @worker.email
        attach_file('worker[image]', 'public/images/test_image.png', make_visible: true)
        within "#worker_gender_#{[true,false].sample}" do
          choose
        end
        find("#worker_character_id > option[value='#{rand(1...3)}']").click
        find("#worker_position_id > option[value='#{rand(1...3)}']").click
        find("#worker_born_1i > option[value='#{rand(1930...2015)}']").click
        find("#worker_born_2i > option[value='#{rand(1...12)}']").click
        find("#worker_born_3i > option[value='#{rand(1...31)}']").click
        
        # アカウント作成ボタンを押すと会社モデルに紐づく社員のカウント(レコード数)が1上がることを確認する。つまり、該当する会社アカウントに所属する社員情報が一つ作成されたことを確認する。
        expect{
          find(".create-account").click
        }.to change {latest_company[0].workers.count }.by(1)

        # 登録された最新の社員情報を取得する
        latest_worker = latest_company[0].workers.order(created_at: :desc).limit(1)
        # アプリ紹介ページにいることを確認する
        expect(current_path).to eq app_tops_path(latest_worker[0])

        # 社員情報登録に成功した場合のみ表示されるFlash要素が表示されていることを確認
        expect(page).to have_content("アカウント登録が完了しました！")

        # ここからがメインの処理になる 💪🏻 今までは、会社登録と社員登録になります
        #物件登録画面へ遷移する
        visit new_property_path

        # 物件登録に必要な値を入力する(正しい値を入力)
        # 物件名称について
        fill_in 'property_owner_utility_equipment_facility_name', with: @property_owner_utility_equipment_facility.name
        fill_in 'property_owner_utility_equipment_facility_name_kana', with: @property_owner_utility_equipment_facility.name_kana
        # 物件所在地について
        fill_in 'property_owner_utility_equipment_facility_post_code', with: @property_owner_utility_equipment_facility.post_code
        find("#property_owner_utility_equipment_facility_prefecture_id > option[value='#{rand(1...47)}']").click
        fill_in 'property_owner_utility_equipment_facility_city', with: @property_owner_utility_equipment_facility.city
        fill_in 'property_owner_utility_equipment_facility_street', with: @property_owner_utility_equipment_facility.street
        # 物件種別について
        find("#property_owner_utility_equipment_facility_type_id > option[value='#{rand(1...3)}']").click
        # 総戸数について
        fill_in 'property_owner_utility_equipment_facility_units', with: @property_owner_utility_equipment_facility.units
        # 管理形態について
        find("#property_owner_utility_equipment_facility_management_form_id > option[value='#{rand(1...7)}']").click
        # ライフラインについて
        find("#property_owner_utility_equipment_facility_water_supply_id > option[value='#{rand(1...2)}']").click
        find("#property_owner_utility_equipment_facility_sewer_id > option[value='#{rand(1...2)}']").click
        find("#property_owner_utility_equipment_facility_electrical_id > option[value='#{rand(1...3)}']").click
        find("#property_owner_utility_equipment_facility_ga_id > option[value='#{rand(1...3)}']").click
        # 物件写真登録について
        attach_file('property_owner_utility_equipment_facility[image]', 'public/images/test_image.png', make_visible: true)
        # 物件ランクについて
        find("#property_owner_utility_equipment_facility_rank_id > option[value='#{rand(1...4)}']").click
        # 所有者名称について
        within "#human-switch" do
          choose
        end
        fill_in "owner-last-name-input", with: @property_owner_utility_equipment_facility.last_name
        fill_in "owner-first-name-input", with: @property_owner_utility_equipment_facility.first_name
        fill_in "owner-last-name-kana-input", with: @property_owner_utility_equipment_facility.last_name_kana
        fill_in "owner-first-name-kana-input", with: @property_owner_utility_equipment_facility.first_name_kana
        # 所有者住所について
        fill_in "property_owner_utility_equipment_facility_owner_post_code", with: @property_owner_utility_equipment_facility.owner_post_code
        find("#property_owner_utility_equipment_facility_owner_prefecture_id > option[value='#{rand(1...47)}']").click
        fill_in "property_owner_utility_equipment_facility_owner_city", with: @property_owner_utility_equipment_facility.owner_city
        fill_in "property_owner_utility_equipment_facility_owner_street", with: @property_owner_utility_equipment_facility.owner_street
        #連絡先等について
        fill_in "property_owner_utility_equipment_facility_main_communication", with: @property_owner_utility_equipment_facility.main_communication
        fill_in "property_owner_utility_equipment_facility_communication_about", with: @property_owner_utility_equipment_facility.communication_about

        # 物件情報登録ボタンを押すと物件・ライフライン・オーナー・オーナー勤務先のすべてのカウント(レコード数)が1上がることを確認する。
        expect{
          find(".submit-btn").click
        }.to change { Property.count }.by(1) & change { Utility.count }.by(1) & change { Owner.count }.by(1) & change { OwnerWorkCompany.count }.by(1)

        # 物件一覧ページにいることを確認する
        expect(current_path).to eq sort_property_path(1)

        # 物件登録に成功した場合のみ表示されるFlash要素が表示されていることを確認
        expect(page).to have_content("物件登録が完了しました！")

      end
    end
    context '⇢ 所有形態が法人の場合' do #  🤚
      before do
        # 法人用の情報をビルドする
        @property_owner_utility_equipment_facility = FactoryBot.build(:property_owner_utility_equipment_facility, :owner_swicth_is_company)
      end
      it '正しい値を入力した場合 ⇢ 物件情報が登録でき、物件一覧画面に移動する' do
        # 🔴 【後でやる作業】ボタンがあることなどを確認する。アプリ紹介ページに行って、登録できていないことを確認する。
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        # expect(page).to have_content('新規登録')
        # # 新規登録ページへ移動する
        # visit new_user_registration_path

        # 会社アカウント登録ページへ移動する
        visit new_company_registration_path

        # 会社アカウント登録に必要な情報を入力する
        fill_in 'company_name', with: @company.name
        attach_file('company[image]', 'public/images/test_image.png', make_visible: true)
        fill_in 'company_company_login_id', with: @company.company_login_id
        fill_in 'company_email', with: @company.email
        fill_in 'company_password', with: @company.password
        fill_in 'company_password_confirmation', with: @company.password_confirmation
        fill_in 'company_post_code', with: @company.post_code
        find("#company_prefecture_id > option[value='#{rand(1...47)}']").click
        fill_in 'company_city', with: @company.city
        fill_in 'company_street', with: @company.street

        # アカウント作成ボタンを押すと会社モデルのカウント(レコード数)が1上がることを確認する。つまり、アカウントが作成されたことを確認する。
        expect{
          find(".create-account").click
        }.to change { Company.count }.by(1)

        # 登録された最新のアカウントを取得する
        latest_company = Company.order(created_at: :desc).limit(1)

        # 登録されたアカウントが入力したアカウントと同じかを確認する。
        # テストの際に理解しやすくするために作成している、後クエリパラメータにデバイスの仕様かわからないけど、パスを判定できないため生成している。
        expect(@company.company_login_id == latest_company[0].company_login_id ).to eq true

        # ログイン後社員アカウント作成ページへ遷移する事を確認する
        expect(current_path).to eq new_worker_registration_path(latest_company[0].id)

        # ログインに成功した場合のみ表示されるFlash要素が表示されていることを確認
        expect(page).to have_content("会社アカウントが登録されました！")
        
        # ここからが社員登録処理

        # 社員情報登録に必要な値を入力する
        fill_in 'worker_worker_login_id', with: @worker.worker_login_id
        fill_in 'worker_password', with: @worker.password
        fill_in 'worker_password_confirmation', with: @worker.password_confirmation
        fill_in "worker_last_name", with: @worker.last_name
        fill_in "worker_first_name", with: @worker.first_name
        fill_in "worker_last_name_kana", with: @worker.last_name_kana
        fill_in "worker_first_name_kana", with: @worker.first_name_kana
        fill_in 'worker_email', with: @worker.email
        attach_file('worker[image]', 'public/images/test_image.png', make_visible: true)
        within "#worker_gender_#{[true,false].sample}" do
          choose
        end
        find("#worker_character_id > option[value='#{rand(1...3)}']").click
        find("#worker_position_id > option[value='#{rand(1...3)}']").click
        find("#worker_born_1i > option[value='#{rand(1930...2015)}']").click
        find("#worker_born_2i > option[value='#{rand(1...12)}']").click
        find("#worker_born_3i > option[value='#{rand(1...31)}']").click
        
        # アカウント作成ボタンを押すと会社モデルに紐づく社員のカウント(レコード数)が1上がることを確認する。つまり、該当する会社アカウントに所属する社員情報が一つ作成されたことを確認する。
        expect{
          find(".create-account").click
        }.to change {latest_company[0].workers.count }.by(1)

        # 登録された最新の社員情報を取得する
        latest_worker = latest_company[0].workers.order(created_at: :desc).limit(1)
        # アプリ紹介ページにいることを確認する
        expect(current_path).to eq app_tops_path(latest_worker[0])

        # 社員情報登録に成功した場合のみ表示されるFlash要素が表示されていることを確認
        expect(page).to have_content("アカウント登録が完了しました！")

        # ここからがメインの処理になる 💪🏻 今までは、会社登録と社員登録になります
        #物件登録画面へ遷移する
        visit new_property_path

        # 物件登録に必要な値を入力する(正しい値を入力)
        # 物件名称について
        fill_in 'property_owner_utility_equipment_facility_name', with: @property_owner_utility_equipment_facility.name
        fill_in 'property_owner_utility_equipment_facility_name_kana', with: @property_owner_utility_equipment_facility.name_kana
        # 物件所在地について
        fill_in 'property_owner_utility_equipment_facility_post_code', with: @property_owner_utility_equipment_facility.post_code
        find("#property_owner_utility_equipment_facility_prefecture_id > option[value='#{rand(1...47)}']").click
        fill_in 'property_owner_utility_equipment_facility_city', with: @property_owner_utility_equipment_facility.city
        fill_in 'property_owner_utility_equipment_facility_street', with: @property_owner_utility_equipment_facility.street
        # 物件種別について
        find("#property_owner_utility_equipment_facility_type_id > option[value='#{rand(1...3)}']").click
        # 総戸数について
        fill_in 'property_owner_utility_equipment_facility_units', with: @property_owner_utility_equipment_facility.units
        # 管理形態について
        find("#property_owner_utility_equipment_facility_management_form_id > option[value='#{rand(1...7)}']").click
        # ライフラインについて
        find("#property_owner_utility_equipment_facility_water_supply_id > option[value='#{rand(1...2)}']").click
        find("#property_owner_utility_equipment_facility_sewer_id > option[value='#{rand(1...2)}']").click
        find("#property_owner_utility_equipment_facility_electrical_id > option[value='#{rand(1...3)}']").click
        find("#property_owner_utility_equipment_facility_ga_id > option[value='#{rand(1...3)}']").click
        # 物件写真登録について
        attach_file('property_owner_utility_equipment_facility[image]', 'public/images/test_image.png', make_visible: true)
        # 物件ランクについて
        find("#property_owner_utility_equipment_facility_rank_id > option[value='#{rand(1...4)}']").click
        # 所有者名称について
        within "#company-switch" do
          choose
        end
        fill_in "owner-company-name-input", with: @property_owner_utility_equipment_facility.owner_company_name
        fill_in "owner-company-name-kana-input", with: @property_owner_utility_equipment_facility.owner_company_name_kana
        # 所有者住所について
        fill_in "property_owner_utility_equipment_facility_owner_post_code", with: @property_owner_utility_equipment_facility.owner_post_code
        find("#property_owner_utility_equipment_facility_owner_prefecture_id > option[value='#{rand(1...47)}']").click
        fill_in "property_owner_utility_equipment_facility_owner_city", with: @property_owner_utility_equipment_facility.owner_city
        fill_in "property_owner_utility_equipment_facility_owner_street", with: @property_owner_utility_equipment_facility.owner_street
        #連絡先等について
        fill_in "property_owner_utility_equipment_facility_main_communication", with: @property_owner_utility_equipment_facility.main_communication
        fill_in "property_owner_utility_equipment_facility_communication_about", with: @property_owner_utility_equipment_facility.communication_about

        # 物件情報登録ボタンを押すと物件・ライフライン・オーナー・オーナー勤務先のすべてのカウント(レコード数)が1上がることを確認する。
        expect{
          find(".submit-btn").click
        }.to change { Property.count }.by(1) & change { Utility.count }.by(1) & change { Owner.count }.by(1) & change { OwnerWorkCompany.count }.by(1)

        # 物件一覧ページにいることを確認する
        expect(current_path).to eq sort_property_path(1)

        # 物件登録に成功した場合のみ表示されるFlash要素が表示されていることを確認
        expect(page).to have_content("物件登録が完了しました！")
      end
    end
  end
  context '新規登録ができないとき' do #  🤚
    context '⇢ 所有形態が個人・法人ともに共通の状況' do # 🤚
      it '不正な値を入力した場合 ⇢ 物件情報が登録できず、物件情報登録画面に戻ってくる' do
        # 🔴 【後でやる作業】ボタンがあることなどを確認する。アプリ紹介ページに行って、登録できていないことを確認する。
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        # expect(page).to have_content('新規登録')
        # # 新規登録ページへ移動する
        # visit new_user_registration_path

        # 会社アカウント登録ページへ移動する
        visit new_company_registration_path

        # 会社アカウント登録に必要な情報を入力する
        fill_in 'company_name', with: @company.name
        attach_file('company[image]', 'public/images/test_image.png', make_visible: true)
        fill_in 'company_company_login_id', with: @company.company_login_id
        fill_in 'company_email', with: @company.email
        fill_in 'company_password', with: @company.password
        fill_in 'company_password_confirmation', with: @company.password_confirmation
        fill_in 'company_post_code', with: @company.post_code
        find("#company_prefecture_id > option[value='#{rand(1...47)}']").click
        fill_in 'company_city', with: @company.city
        fill_in 'company_street', with: @company.street

        # アカウント作成ボタンを押すと会社モデルのカウント(レコード数)が1上がることを確認する。つまり、アカウントが作成されたことを確認する。
        expect{
          find(".create-account").click
        }.to change { Company.count }.by(1)

        # 登録された最新のアカウントを取得する
        latest_company = Company.order(created_at: :desc).limit(1)

        # 登録されたアカウントが入力したアカウントと同じかを確認する。
        # テストの際に理解しやすくするために作成している、後クエリパラメータにデバイスの仕様かわからないけど、パスを判定できないため生成している。
        expect(@company.company_login_id == latest_company[0].company_login_id ).to eq true

        # ログイン後社員アカウント作成ページへ遷移する事を確認する
        expect(current_path).to eq new_worker_registration_path(latest_company[0].id)

        # ログインに成功した場合のみ表示されるFlash要素が表示されていることを確認
        expect(page).to have_content("会社アカウントが登録されました！")
        
        # ここからが社員登録処理

        # 社員情報登録に必要な値を入力する
        fill_in 'worker_worker_login_id', with: @worker.worker_login_id
        fill_in 'worker_password', with: @worker.password
        fill_in 'worker_password_confirmation', with: @worker.password_confirmation
        fill_in "worker_last_name", with: @worker.last_name
        fill_in "worker_first_name", with: @worker.first_name
        fill_in "worker_last_name_kana", with: @worker.last_name_kana
        fill_in "worker_first_name_kana", with: @worker.first_name_kana
        fill_in 'worker_email', with: @worker.email
        attach_file('worker[image]', 'public/images/test_image.png', make_visible: true)
        within "#worker_gender_#{[true,false].sample}" do
          choose
        end
        find("#worker_character_id > option[value='#{rand(1...3)}']").click
        find("#worker_position_id > option[value='#{rand(1...3)}']").click
        find("#worker_born_1i > option[value='#{rand(1930...2015)}']").click
        find("#worker_born_2i > option[value='#{rand(1...12)}']").click
        find("#worker_born_3i > option[value='#{rand(1...31)}']").click
        
        # アカウント作成ボタンを押すと会社モデルに紐づく社員のカウント(レコード数)が1上がることを確認する。つまり、該当する会社アカウントに所属する社員情報が一つ作成されたことを確認する。
        expect{
          find(".create-account").click
        }.to change {latest_company[0].workers.count }.by(1)

        # 登録された最新の社員情報を取得する
        latest_worker = latest_company[0].workers.order(created_at: :desc).limit(1)
        # アプリ紹介ページにいることを確認する
        expect(current_path).to eq app_tops_path(latest_worker[0])

        # 社員情報登録に成功した場合のみ表示されるFlash要素が表示されていることを確認
        expect(page).to have_content("アカウント登録が完了しました！")

        # ここからがメインの処理になる 💪🏻 今までは、会社登録と社員登録になります
        #物件登録画面へ遷移する
        visit new_property_path

        # 物件登録に不正な値を送信する(何も情報を打ち込まない)

        # 物件情報登録ボタンを押すと物件・ライフライン・オーナー・オーナー勤務先のすべてのカウント(レコード数)が上がらないことを確認する。
        expect{
          find(".submit-btn").click
        }.to change { Property.count }.by(0) & change { Utility.count }.by(0) & change { Owner.count }.by(0) & change { OwnerWorkCompany.count }.by(0)

        # 再度、物件登録ページに戻って来ることを確認する
        expect(current_path).to eq "/properties"

        # 物件登録に失敗した場合のみ表示されるFlash要素が表示されていることを確認
        expect(page).to have_content("入力不備のため登録ができません")

      end
    end
  end
end
