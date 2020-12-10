require 'rails_helper'
#systemspecで結合テスト

RSpec.describe "新規会社アカウント登録 -結合テスト", type: :system do
  before do
    @company = FactoryBot.build(:company)
    #時間を止めたい時に「stop 10」とすると10秒止まるメソッド。
    def stop(seconds = 0)
      sleep seconds
    end
  end
  context '新規登録ができるとき' do #  🤚
    it '正しい値を入力した場合 ⇢ 会社アカウントが作成でき、社員登録画面に移動する' do

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
      # テストの際に理解しやすくするために作成している
      expect(@company.company_login_id == latest_company[0].company_login_id ).to eq true

      # ログイン後社員アカウント作成ページへ遷移する
      expect(current_path).to eq new_worker_registration_path(latest_company[0].id)

      # ログインに成功した場合のみ表示されるFlash要素が表示されていることを確認
      expect(page).to have_content("#{latest_company[0].name}")
      expect(page).to have_content("#{latest_company[0].company_login_id}")

    end
  end
  context '新規登録ができないとき' do #  🤚
    it '不正な値を入力した場合 ⇢ 会社アカウントが作成できず、会社アカウント登録画面に戻ってくる' do

      # 🔴 【後でやる作業】ボタンがあることなどを確認する。アプリ紹介ページに行って、登録できていないことを確認する。
      # トップページに移動する
      # visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      # expect(page).to have_content('新規登録')

      # 会社アカウント登録ページへ移動する
      visit new_company_registration_path
      # 会社アカウント登録に必要な情報を入力するが、prefecture_idのみ不正な値を入力する
      fill_in 'company_name', with: @company.name
      attach_file('company[image]', 'public/images/test_image.png', make_visible: true)
      fill_in 'company_company_login_id', with: @company.company_login_id
      fill_in 'company_email', with: @company.email
      fill_in 'company_password', with: @company.password
      fill_in 'company_password_confirmation', with: @company.password_confirmation
      fill_in 'company_post_code', with: @company.post_code
      #ここで不正な値0を入力する
      find("#company_prefecture_id > option[value='0']").click
      fill_in 'company_city', with: @company.city
      fill_in 'company_street', with: @company.street

      # アカウント作成ボタンを押すと会社モデルのカウント(レコード数)が上がらないことを確認する。つまり、アカウントが作成されなかったことを確認する。
      expect{
        find(".create-account").click
      }.to change { Company.count }.by(0)

      # 再度、会社アカウント登録画面に移動する(renderの再現になる)
      expect(current_path).to eq "/companies"
    end
  end
end


# 以下は会社アカウントログイン


RSpec.describe "会社アカウントログイン -結合テスト", type: :system do
  before do
    # 時間調整 デフォルト:0 , 確認したい時は3を推奨。
    def stop(seconds = 0)
      sleep seconds
    end
  end
  context 'ログインに成功する場合' do
    it 'ログインに成功し、社員ログインページに遷移する' do
      # 予め、会社アカウントをDBに保存し会社ログイン成功のテストの準備をする
      @company = FactoryBot.create(:company)
      # ログインページへ移動する
      visit  new_company_session_path
      # ログインページに遷移していることを確認する
      expect(current_path).to eq new_company_session_path
      # すでに保存されているユーザーのcompany_login_idとpasswordを入力する
      fill_in "company_company_login_id", with: @company.company_login_id
      fill_in "company_password", with: @company.password
      # ログインボタンをクリックする
      find('.create-account').click
      # 社員ログインページに遷移していることを確認する
      expect(current_path).to eq new_worker_session_path
      # 会社ログイン成功時のメッセージが表示されていることを確認する
      expect(page).to have_content('会社でログインしました！')
    end
  end
  context 'ログインに失敗する場合' do
    it 'ログインに失敗し、再びサインインページに戻ってくる' do
      # 予め、会社アカウントをDBに保存し会社ログイン失敗のテストの準備をする
      @company =FactoryBot.create(:company)
      # サインインページに遷移する
      visit new_company_session_path
      # サインインページに遷移していることを確認する
      expect(current_path).to eq new_company_session_path
      # 誤った会社アカウント情報を入力する
      fill_in "company_company_login_id", with:"hoge"
      fill_in "company_password", with:"hoge"
      # ログインボタンをクリックする
      find('.create-account').click
      # 会社ログインページに戻ってきていることを確認する
      expect(current_path).to eq new_company_session_path
      # 会社ログイン失敗時のメッセージが表示されていることを確認する
      expect(page).to have_content('アカウントIDまたはパスワードが違います。')
    end
  end
end