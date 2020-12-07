require 'rails_helper'

RSpec.describe Company, type: :model do
  before do
    @company = FactoryBot.build(:company)
  end

  describe '会社アカウント新規登録' do
    #正常系
    context '新規登録が成功する時' do
      it 'name｜company_login_id|email|password｜password_confirmation｜post_code｜prefecture_id｜city｜street｜image |が存在すれば登録できる' do
        expect(@company).to be_valid
      end
      it 'passwordが6文字以上であれば登録できること' do
        @company.password = '123456'
        @company.password_confirmation = '123456'
        expect(@company).to be_valid
      end
    end
#name関係
    context '新規登録が失敗する時' do
      it 'nameが空では登録できないこと' do
        @company.name = nil
        @company.valid?
        expect(@company.errors.full_messages).to include("会社名称を入力してください")
      end
#image関係
      it 'imageが空では登録できないこと' do
        @company.image = nil
        @company.valid?
        expect(@company.errors.full_messages).to include("会社プロフィール画像を入力してください")
      end
#company_login_id関係
      it 'company_login_idが空では登録できないこと' do
        @company.company_login_id = nil
        @company.valid?
        expect(@company.errors.full_messages).to include("アカウントIDを入力してください")
      end
      it 'company_login_idが5文字以下だと登録できないこと' do
        @company.company_login_id = "Ab123"
        @company.valid?
        expect(@company.errors.full_messages).to include("アカウントIDは半角6~12文字かつ英大文字・小文字・数字それぞれ１文字以上を含むように入力してください")
      end
      it 'company_login_idが13文字以上だと登録できないこと' do
        @company.company_login_id = "ABCDEF1234567"
        @company.valid?
        expect(@company.errors.full_messages).to include("アカウントIDは半角6~12文字かつ英大文字・小文字・数字それぞれ１文字以上を含むように入力してください")
      end
      it 'company_login_idは半角英数字でないと登録できないこと' do
        @company.company_login_id = "Ａbc12３"
        @company.valid?
        expect(@company.errors.full_messages).to include("アカウントIDは半角6~12文字かつ英大文字・小文字・数字それぞれ１文字以上を含むように入力してください")
      end
      it 'company_login_idは英大文字・小文字・数字それぞれ１文字以上含まないと登録できないこと' do
        @company.company_login_id = "abc123"
        @company.valid?
        expect(@company.errors.full_messages).to include("アカウントIDは半角6~12文字かつ英大文字・小文字・数字それぞれ１文字以上を含むように入力してください")
      end
      it 'company_login_idが重複している場合は登録できない' do
        @company.save
        another_company= FactoryBot.build(:company, company_login_id: @company.company_login_id )
        another_company.valid?
        expect(another_company.errors.full_messages).to include("アカウントIDはすでに存在します")
      end
# 郵便番号関係
      it 'post_codeが空だと登録できない' do
        @company.post_code = nil
        @company.valid?
        expect(@company.errors.full_messages).to include
        "郵便番号を入力してください"
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと(全角伸ばし棒で検証)' do
        @company.post_code = '123ー4567'
        @company.valid?
        expect(@company.errors.full_messages).to include('郵便番号にハイフンが含まれていません')
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと(ハイフンなしで検証)' do
        @company.post_code = '1234567'
        @company.valid?
        expect(@company.errors.full_messages).to include('郵便番号にハイフンが含まれていません')
      end
      it 'post_codeは ○ ○ ○ - ○ ○ ○ ○ という形で入力しないと登録できない( ○ は半角数字とする)' do
        @company.post_code = '1234-567'
        @company.valid?
        expect(@company.errors.full_messages).to include('郵便番号にハイフンが含まれていません')
      end
#都道府県関連
      it 'prefecture_idを選択していないと登録できない' do
        @company.prefecture_id = 0
        @company.valid?
        expect(@company.errors.full_messages).to include("都道府県を選択してください")
      end
#市区町村関連
      it 'cityが空の場合には登録できない' do
        @company.city = nil
        @company.valid?
        expect(@company.errors.full_messages).to include("市区町村を入力してください")
      end
#番地関連
      it 'streetが空の場合には登録できない' do
        @company.street = nil
        @company.valid?
        expect(@company.errors.full_messages).to include("番地を入力してください")
      end
#パスワード関係
      it 'passordが空では登録できないこと' do
        @company.password = nil
        @company.valid?
        expect(@company.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @company.password = '12345'
        @company.valid?
        expect(@company.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できないこと' do
        @company.password_confirmation = ''
        @company.valid?
        expect(@company.errors.full_messages).to include("確認用パスワードとパスワードの入力が一致しません")
      end
      it 'passwordとpassword_confirmationの値が異なる場合登録できないこと' do
        @company.password = 'test0000@.com'
        @company.password_confirmation = 'test1111@.com'
        @company.valid?
        expect(@company.errors.full_messages).to include("確認用パスワードとパスワードの入力が一致しません")
      end
      #email関係
      it 'emailが空では登録できないこと' do
        @company.email = nil
        @company.valid?
        expect(@company.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it '重複したemailが存在する場合登録できないこと' do
        @company.save
        another_user = FactoryBot.build(:company, email: @company.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end
      it 'emailの中に@が含まれていない場合は登録できないこと' do
        @company.email = @company.email.gsub(/@/, '')
        @company.valid?
        expect(@company.errors.full_messages).to include('メールアドレスは不正な値です')
      end
    end
  end
end
