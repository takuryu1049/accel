require 'rails_helper'

RSpec.describe "新規社員アカウント登録 -結合テスト", type: :system do
  before do
    @worker = FactoryBot.build(:worker)
    @company = @worker.company
    #時間を止めたい時に「stop 10」とすると10秒止まるメソッド。
    def stop(seconds = 0)
      sleep seconds
    end
  end
  context '新規登録ができるとき' do #  🤚
    it '正しい値を入力した場合 ⇢ 社員アカウントが作成でき、アプリTOP登録画面に移動する' do
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
      expect(page).to have_content("#{latest_company[0].name}")
      expect(page).to have_content("#{latest_company[0].company_login_id}")
      
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
    end
  end
  context '新規登録ができないとき' do #  🤚
    it '不正な値を入力した場合 ⇢ 社員アカウントが作成できず、社員情報登録画面に戻ってくる' do

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
      expect(page).to have_content("#{latest_company[0].name}")
      expect(page).to have_content("#{latest_company[0].company_login_id}")

      # ここからが社員登録処理(故意に失敗させる)

      # 社員情報登録に不正な値を入力する
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
      # 自分の性格飲み不正な値を入力する
      find("#worker_character_id > option[value='0']").click
      find("#worker_position_id > option[value='#{rand(1...3)}']").click
      find("#worker_born_1i > option[value='#{rand(1930...2015)}']").click
      find("#worker_born_2i > option[value='#{rand(1...12)}']").click
      find("#worker_born_3i > option[value='#{rand(1...31)}']").click
      
      # アカウント作成ボタンを押すと会社モデルに紐づく社員のカウント(レコード数)が1上がることを確認する。つまり、該当する会社アカウントに所属する社員情報が作成されないことを確認する。
      expect{
        find(".create-account").click
      }.to change {latest_company[0].workers.count }.by(0)

      # 社員登録画面に戻って生きていることを確認する
      expect(current_path).to eq "/workers"
    end
  end
end


# 以下は社員アカウントログイン😁


# RSpec.describe "社員アカウントログイン -結合テスト", type: :system do
#   before do
#     # 時間調整 デフォルト:0 , 確認したい時は3を推奨。
#     def stop(seconds = 0)
#       sleep seconds
#     end
#   end
#   context 'ログインに成功する場合' do
#     it 'ログインに成功し、アプリTOPページに遷移する' do
#       # 予め、会社アカウント・社員アカウントをDBに保存し会社ログイン成功のテストの準備をする
#       @worker = FactoryBot.create(:worker)
#       @company = @worker.company

#       #一度会社をログインさせる。

#       # 会社ログインページへ移動する
#       visit  new_company_session_path
#       # 会社ログインページに遷移していることを確認する
#       expect(current_path).to eq new_company_session_path
#       # すでに保存されているユーザーのcompany_login_idとpasswordを入力する
#       fill_in "company_company_login_id", with: @company.company_login_id
#       fill_in "company_password", with: @company.password
#       # 会社ログインボタンをクリックする
#       find('.create-account').click
#       # 社員ログインページに遷移していることを確認する
#       expect(current_path).to eq new_worker_session_path
#       # 会社ログイン成功時のメッセージが表示されていることを確認する
#       expect(page).to have_content('会社ログイン済。社員ログインが必要')
      
#       # ここから社員ログインを行っていく

#       # フォームに正常な値を入力する
#       fill_in "worker_worker_login_id", with: @worker.worker_login_id
#       fill_in "worker_password", with: @worker.password
#       # 社員ログインボタンをクリックする
#       find('.create-account').click
#       # 社員ログインページに遷移していることを確認する
#       expect(current_path).to eq app_tops_path(@worker.id)
#       # 会社ログイン成功時のメッセージが表示されていることを確認する
#       expect(page).to have_content('ログインしました！')
#     end
#   end
#   context 'ログインに失敗する場合' do
#     it 'ログインに失敗し、再びサインインページに戻ってくる' do
#       # 予め、会社アカウント・社員アカウントをDBに保存し会社ログイン成功のテストの準備をする
#       @worker = FactoryBot.create(:worker)
#       @company = @worker.company

#       #一度会社をログインさせる。

#       # 会社ログインページへ移動する
#       visit  new_company_session_path
#       # 会社ログインページに遷移していることを確認する
#       expect(current_path).to eq new_company_session_path
#       # すでに保存されているユーザーのcompany_login_idとpasswordを入力する
#       fill_in "company_company_login_id", with: @company.company_login_id
#       fill_in "company_password", with: @company.password
#       # 会社ログインボタンをクリックする
#       find('.create-account').click
#       # 社員ログインページに遷移していることを確認する
#       expect(current_path).to eq new_worker_session_path
#       # 会社ログイン成功時のメッセージが表示されていることを確認する
#       expect(page).to have_content('会社ログイン済。社員ログインが必要')
#       # ここから社員ログインを行っていく
#       # フォームに不正な値を入力する(今回は全て「hogeと入力する」)
#       fill_in "worker_worker_login_id", with: "hoge"
#       fill_in "worker_password", with: "hoge"
#       # 社員ログインボタンをクリックする
#       find('.create-account').click
#       # # 会社ログインページに戻ってきていることを確認する
#       expect(current_path).to eq new_worker_session_path
#       # 会社ログイン失敗時のメッセージが表示されていることを確認する
#       expect(page).to have_content('社員情報が間違えています')
#     end
#   end
# end