require 'rails_helper'

RSpec.describe Worker, type: :model do
  before do
    @worker = FactoryBot.build(:worker)
  end

  describe '社員アカウント新規登録' do
    #正常系
    context '新規登録が成功する時' do
      it 'worker_login_id｜password｜password_confirmation｜last_name｜first_name｜last_name_kana｜first_name_kana | email | image | gender | character_id | position_id | born |が存在すれば登録できる' do
        expect(@worker).to be_valid
      end
      it 'passwordが6文字以上であれば登録できること' do
        @worker.password = '123456'
        @worker.password_confirmation = '123456'
        expect(@worker).to be_valid
      end
    end
    context '新規登録が失敗する時' do
      context 'worker_login_idについて' do
        it 'worker_login_idが空では登録できないこと' do
          @worker.worker_login_id = nil
          @worker.valid?
          expect(@worker.errors.full_messages).to include("社員アカウントIDを入力してください")
        end
        it 'worker_login_idが5文字以下だと登録できないこと' do
          @worker.worker_login_id = "Ab123"
          @worker.valid?
          expect(@worker.errors.full_messages).to include("社員アカウントIDは半角6~12文字かつ英大文字・小文字・数字それぞれ１文字以上を含むように入力してください")
        end
        it 'worker_login_idが13文字以上だと登録できないこと' do
          @worker.worker_login_id = "ABCDEF1234567"
          @worker.valid?
          expect(@worker.errors.full_messages).to include("社員アカウントIDは半角6~12文字かつ英大文字・小文字・数字それぞれ１文字以上を含むように入力してください")
        end
        it 'worker_login_idは半角英数字でないと登録できないこと' do
          @worker.worker_login_id = "Ａbc12３"
          @worker.valid?
          expect(@worker.errors.full_messages).to include("社員アカウントIDは半角6~12文字かつ英大文字・小文字・数字それぞれ１文字以上を含むように入力してください")
        end
        it 'worker_login_idは英大文字・小文字・数字それぞれ１文字以上含まないと登録できないこと' do
          @worker.worker_login_id = "abc123"
          @worker.valid?
          expect(@worker.errors.full_messages).to include("社員アカウントIDは半角6~12文字かつ英大文字・小文字・数字それぞれ１文字以上を含むように入力してください")
        end
        it 'worker_login_idが重複している場合は登録できない' do
          @worker.save
          another_worker= FactoryBot.build(:worker, worker_login_id: @worker.worker_login_id )
          another_worker.valid?
          expect(another_worker.errors.full_messages).to include("社員アカウントIDはすでに存在します")
        end
      end
      context 'passwordとpassword_confirmationについて' do
        it 'passordが空では登録できないこと' do
          @worker.password = nil
          @worker.valid?
          expect(@worker.errors.full_messages).to include("パスワードを入力してください")
        end
        it 'passwordが5文字以下であれば登録できない' do
          @worker.password = '12345'
          @worker.valid?
          expect(@worker.errors.full_messages).to include('パスワードは6文字以上で入力してください')
        end
        it 'passwordが存在してもpassword_confirmationが空では登録できないこと' do
          @worker.password_confirmation = ''
          @worker.valid?
          expect(@worker.errors.full_messages).to include("確認用パスワードとパスワードの入力が一致しません")
        end
        it 'passwordとpassword_confirmationの値が異なる場合登録できないこと' do
          @worker.password = 'test0000@.com'
          @worker.password_confirmation = 'test1111@.com'
          @worker.valid?
          expect(@worker.errors.full_messages).to include("確認用パスワードとパスワードの入力が一致しません")
        end
      end
      context '姓 名 姓(カナ) 名(カナ)について' do
        it '姓が空では登録できないこと' do
          @worker.last_name = nil
          @worker.valid?
          expect(@worker.errors.full_messages).to include("姓を入力してください")
        end
        it '姓が全角ひらがな、全角カタカナ、漢字ではない文字列が含まれている場合登録できないこと' do
          @worker.last_name = 'aあ１いち三３ｱ'
          @worker.valid?
          expect(@worker.errors.full_messages).to include('姓は全角ひらがな、全角カタカナ、漢字のいずれかで入力してください')
        end
        it '名が空では登録できないこと' do
          @worker.first_name = nil
          @worker.valid?
          expect(@worker.errors.full_messages).to include("名を入力してください")
        end
        it '名が全角ひらがな、全角カタカナ、漢字ではない文字列が含まれている場合登録できないこと' do
          @worker.first_name = 'aあ１いち三３ｱ'
          @worker.valid?
          expect(@worker.errors.full_messages).to include('名は全角ひらがな、全角カタカナ、漢字でのいずれかで入力してください')
        end
        it '姓(カナ)が空では登録できないこと' do
          @worker.last_name_kana = nil
          @worker.valid?
          expect(@worker.errors.full_messages).to include("姓(カナ)を入力してください")
        end
        it '姓(カナ)が全角カタカナではない文字列が含まれている場合登録できないこと' do
          @worker.last_name_kana = 'あ漢ｱ'
          @worker.valid?
          expect(@worker.errors.full_messages).to include('姓(カナ)は全角カタカナで入力してください')
        end
        it '名(カナ)が空では登録できないこと' do
          @worker.first_name_kana = nil
          @worker.valid?
          expect(@worker.errors.full_messages).to include("名(カナ)を入力してください")
        end
        it 'f名(カナ)が全角カタカナではない文字列が含まれている場合登録できないこと' do
          @worker.first_name_kana = 'あ漢ｱ'
          @worker.valid?
          expect(@worker.errors.full_messages).to include('名(カナ)は全角カタカナで入力してください')
        end
      end
      context 'メールアドレスについて' do
        it 'emailが空では登録できないこと' do
          @worker.email = nil
          @worker.valid?
          expect(@worker.errors.full_messages).to include("メールアドレスを入力してください")
        end
        it '重複したemailが存在する場合登録できないこと' do
          @worker.save
          another_worker = FactoryBot.build(:worker, email: @worker.email)
          another_worker.valid?
          expect(another_worker.errors.full_messages).to include('メールアドレスはすでに存在します')
        end
        it 'emailの中に@が含まれていない場合は登録できないこと' do
          @worker.email = @worker.email.gsub(/@/, '')
          @worker.valid?
          expect(@worker.errors.full_messages).to include('メールアドレスは不正な値です')
        end
      end
      context 'プロフィール画像について' do
        it 'imageが空では登録できないこと' do
          @worker.image = nil
          @worker.valid?
          expect(@worker.errors.full_messages).to include("社員プロフィール画像を入力してください")
        end
      end
      context '性別について' do
        it '性別が選択されていないと登録できないこと' do
          @worker.gender = nil
          @worker.valid?
          expect(@worker.errors.full_messages).to include("性別を選択してください")
        end
      end
      context '自分の性格について' do
        it '自分の性格を選択していないと登録できない' do
          @worker.character_id= 0
          @worker.valid?
          expect(@worker.errors.full_messages).to include("自分の性格を選択してください")
        end
      end
      context '役職について' do
        it '役職を選択していないと登録できない' do
          @worker.position_id = 0
          @worker.valid?
          expect(@worker.errors.full_messages).to include("役職を選択してください")
        end
      end
      context '誕生年月日について' do
        it 'bornが空では登録できないこと' do
          @worker.born = nil
          @worker.valid?
          expect(@worker.errors.full_messages).to include("誕生月を入力してください")
        end
      end
    end
  end
end