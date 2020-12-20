require 'rails_helper'

RSpec.describe PropertyOwnerUtilityEquipmentFacility, type: :model do
  
  describe '物件情報新規登録' do
  #正常系
    context '新規登録が成功する時' do
      context '👉 オーナーが個人の場合' do
        before do
          @property_owner_utility_equipment_facility = FactoryBot.build(:property_owner_utility_equipment_facility, :owner_swicth_is_human)
        end
        it 'name, name_kana, post_code, prefecture_id, city, street, type_id, units, management_form_id, water_supply_id, sewer_id, electrical_id, ga_id, image, rank_id,  switch_owner_form, last_name, first_name, first_name_kana, last_name_kana, owner_post_code, owner_prefecture_id, owner_city, owner_street, main_communication, communication_aboutが存在すれば登録できる' do
          expect(@property_owner_utility_equipment_facility).to be_valid
        end
      end
      context '👉 オーナーが法人の場合' do
        before do
          @property_owner_utility_equipment_facility = FactoryBot.build(:property_owner_utility_equipment_facility, :owner_swicth_is_company)
        end
        # 所有者名称についての内容が変わるだけの変更になります
        it 'name, name_kana, post_code, prefecture_id, city, street, type_id, units, management_form_id, water_supply_id, sewer_id, electrical_id, ga_id, image, rank_id, switch_owner_form, owner_company_name, owner_company_name_kana, owner_post_code, owner_prefecture_id, owner_city, owner_street, main_communication, communication_aboutが存在すれば登録できる' do
          expect(@property_owner_utility_equipment_facility).to be_valid
        end
      end
    end
    context '新規登録が失敗する時' do
      context '👉 オーナーが個人の場合' do
        before do
          @property_owner_utility_equipment_facility = FactoryBot.build(:property_owner_utility_equipment_facility, :owner_swicth_is_human)
        end
        context "物件情報について" do
          it 'nameが空では登録できないこと' do
            @property_owner_utility_equipment_facility.name = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("物件名称を入力してください")
          end
          it 'name_kanaが空では登録できないこと' do
            @property_owner_utility_equipment_facility.name_kana = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("物件名称カナを入力してください")
          end
          it 'nama_kanaに全角カタカナではない文字列が含まれている場合登録できないこと' do
            @property_owner_utility_equipment_facility.name_kana = "あいうえおビル"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("物件名称カナは全角カタカナで入力してください")
          end
        end
        context "物件情所在地について" do
          it 'post_codeが空では登録できないこと' do
            @property_owner_utility_equipment_facility.post_code = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("郵便番号を入力してください")
          end
          it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと(全角伸ばし棒で検証)' do
            @property_owner_utility_equipment_facility.post_code = '123ー4567'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('郵便番号にハイフンを含め、000-0000の形式で入力してください')
          end
          it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと(ハイフンなしで検証)' do
            @property_owner_utility_equipment_facility.post_code = '1234567'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('郵便番号にハイフンを含め、000-0000の形式で入力してください')
          end
          it 'post_codeは ○ ○ ○ - ○ ○ ○ ○ という形で入力しないと登録できない( ○ は半角数字とする)' do
            @property_owner_utility_equipment_facility.post_code = '1234-567'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('郵便番号にハイフンを含め、000-0000の形式で入力してください')
          end
          it 'prefecture_idを選択していないと登録できない' do
            @property_owner_utility_equipment_facility.prefecture_id = 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("都道府県を選択してください")
          end
          it 'cityが空の場合には登録できない' do
            @property_owner_utility_equipment_facility.city = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("市区町村を入力してください")
          end
          it 'streetが空の場合には登録できない' do
            @property_owner_utility_equipment_facility.street = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("番地を入力してください")
          end
        end
        context "物件種別について" do
          it 'type_idを選択していない場合は登録できない' do
            @property_owner_utility_equipment_facility.type_id = 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("物件種別を選択してください")
          end
        end
        context "総戸数について" do
          it 'unitsが1より少ない場合には登録できない' do
            @property_owner_utility_equipment_facility.units = 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("総戸数は1~3000の範囲内かつ、半角英数字で入力をしてください")
          end
          it 'unitsが3000より大きい場合には登録できない' do
            @property_owner_utility_equipment_facility.units = 3001
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("総戸数は1~3000の範囲内かつ、半角英数字で入力をしてください")
          end
          it 'unitsに半角数字以外が含まれている場合には登録できない' do
            # ※全角数字を打ち込む
            @property_owner_utility_equipment_facility.units = "１００"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("総戸数は1~3000の範囲内かつ、半角英数字で入力をしてください")
          end
        end
        context "管理形態について" do
          it 'management_form_idを選択していないと登録できない' do
            @property_owner_utility_equipment_facility.management_form_id= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("管理形態を選択してください")
          end
        end
        context "ライフラインについて" do
          it 'water_supply_idを選択していないと登録できない' do
            @property_owner_utility_equipment_facility.water_supply_id= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("上水道の選択が必要です")
          end
          it 'sewer_idを選択していないと登録できない' do
            @property_owner_utility_equipment_facility.sewer_id= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("下水道の選択が必要です")
          end
          it 'electrical_id,を選択していないと登録できない' do
            @property_owner_utility_equipment_facility.electrical_id,= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("電気の選択が必要です")
          end
          it 'ga_idを選択していないと登録できない' do
            @property_owner_utility_equipment_facility.ga_id= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("ガスの選択が必要です")
          end
        end
        context "物件写真登録について" do
          it 'imageが空の場合には登録できない' do
            @property_owner_utility_equipment_facility.image = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("物件画像を選択してください")
          end
        end
        context "物件ランクについて" do
          it 'rank_idを選択していないと登録できない' do
            @property_owner_utility_equipment_facility.rank_id= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("物件ランクを選択してください")
          end
        end
        context "所有者名称について(※swicth_owner_formの値はH)" do
          it 'swicth_owner_formが、空では登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = nil 
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("所有形態の選択が必要")
          end
          # 検証ツール等で異常値が送られてきた場合
          it 'swicth_owner_formの値が"H","C"以外の値が送信されてきた場合には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "Z"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("所有形態が異常な値です")
          end
          it 'last_nameが、空では登録できない' do
            @property_owner_utility_equipment_facility.last_name= nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("姓を入力してください")
          end
          it 'last_nameが全角ひらがな、全角カタカナ、漢字ではない文字列が含まれている場合登録できないこと' do
            @property_owner_utility_equipment_facility.last_name = 'aあ１いち三３ｱ'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('姓は全角ひらがな、全角カタカナ、漢字のいずれかで入力してください')
          end
          it 'last_nameが入力されていても、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("姓は入力しないでください")
          end
          it 'first_nameが、空では登録できない' do
            @property_owner_utility_equipment_facility.first_name= nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("名を入力してください")
          end
          it 'first_name_nameが全角ひらがな、全角カタカナ、漢字ではない文字列が含まれている場合登録できないこと' do
            @property_owner_utility_equipment_facility.first_name = 'aあ１いち三３ｱ'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('名は全角ひらがな、全角カタカナ、漢字のいずれかで入力してください')
          end
          it 'first_nameが入力されていても、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("名は入力しないでください")
          end
          it 'last_name_kanaが、空では登録できない' do
            @property_owner_utility_equipment_facility.last_name_kana= nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("姓(カナ)を入力してください")
          end
          it 'last_name_kanaが全角カタカナではない文字列が含まれている場合登録できないこと' do
            @property_owner_utility_equipment_facility.last_name_kana = 'あ漢ｱ'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('姓(カナ)は全角カタカナで入力してください')
          end
          it 'last_name_kanaが入力されていても、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("姓(カナ)は入力しないでください")
          end
          it 'first_name_kanaが、空では登録できない' do
            @property_owner_utility_equipment_facility.first_name_kana= nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("名(カナ)を入力してください")
          end
          it 'first_name_kanaが全角カタカナではない文字列が含まれている場合登録できないこと' do
            @property_owner_utility_equipment_facility.first_name_kana = 'あ漢ｱ'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('名(カナ)は全角カタカナで入力してください')
          end
          it 'first_name_kanaが入力されていても、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("名(カナ)は入力しないでください")
          end
          it 'owner_company_nameが空でないと登録できない' do
            @property_owner_utility_equipment_facility.owner_company_name= "テスト不動産株式会社"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("会社名は入力しないでください")
          end
          it 'owner_company_name_kanaが空でないと登録できない' do
            @property_owner_utility_equipment_facility.owner_company_name_kana= "テストフドウサンカブシキガイシャ"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("会社名カナは入力しないでください")
          end
        end
        context "所有者について" do
          it 'genderが異常な値で送信された場合には登録できない' do
            # 検証ツールなどで異常な値を送信された場合等
            @property_owner_utility_equipment_facility.gender = "Z"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("性別が異常な値です")
          end
          it 'genderを選択している場合でも、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.gender = ["M","W"].sample
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("性別は入力しないでください")
          end
          it 'character_idが0以外で選択されている状態でも、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.character_id = Faker::Number.between(from: 1, to: 3)
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("性格の選択は不要です")
          end
        end
        context "所有者住所について" do
          it 'owner_post_codeが空では登録できないこと' do
            @property_owner_utility_equipment_facility.owner_post_code= nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("郵便番号を入力してください")
          end
          it 'owner_post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと(全角伸ばし棒で検証)' do
            @property_owner_utility_equipment_facility.owner_post_code = '123ー4567'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('郵便番号にハイフンを含め、000-0000の形式で入力してください')
          end
          it 'owner_post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと(ハイフンなしで検証)' do
            @property_owner_utility_equipment_facility.owner_post_code = '1234567'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('郵便番号にハイフンを含め、000-0000の形式で入力してください')
          end
          it 'owner_post_codeは ○ ○ ○ - ○ ○ ○ ○ という形で入力しないと登録できない( ○ は半角数字とする)' do
            @property_owner_utility_equipment_facility.owner_post_code = '1234-567'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('郵便番号にハイフンを含め、000-0000の形式で入力してください')
          end
          it 'owner_prefecture_idが選択されていない場合は登録できないこと' do
            @property_owner_utility_equipment_facility.owner_prefecture_id= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("都道府県を選択してください")
          end
          it 'owner_cityが空では登録できないこと' do
            @property_owner_utility_equipment_facility.owner_city= nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("市区町村を入力してください")
          end
          it 'owner_streetが、空では登録できないこと' do
            @property_owner_utility_equipment_facility.owner_street= nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("番地を入力してください")
          end
        end
        context "連絡先等について" do
          it 'main_communicationが空では登録できないこと' do
            @property_owner_utility_equipment_facility.main_communication = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("主要やり取り人物を入力してください")
          end
          it 'communication_aboutが空では登録できないこと' do
            @property_owner_utility_equipment_facility.communication_about = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("やり取り方法についてを入力してください")
          end
        end
        context "勤務先情報について" do
          it 'w_company_nameが入力されていても、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.w_company_name = "テスト株式会社"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("会社名は入力しないでください")
          end
          it 'w_company_name_kanaが入力されていても、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.w_company_name_kana = "テストカブシキガイシャ"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("会社名(カナ)は入力しないでください")
          end
          it 'w_post_codeが入力されていても、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.w_post_code = "123-1234"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("郵便番号は入力しないでください")
          end
          it 'w_prefecture_idが0以外で選択されている状態でも、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.w_prefecture_id = 1
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("都道府県の選択は不要です")
          end
          it 'w_cityが入力されていても、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.w_city= "東京都渋谷区渋谷"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("市区町村は入力しないでください")
          end
          it 'w_streetが入力されていても、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.w_street = "１−１−１"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("番地は入力しないでください")
          end
          it 'w_building_nameが入力されていても、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.w_building_name = "テストアパート101"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("建物名は入力しないでください")
          end
          it 'w_company_phone_numが入力されていても、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.w_company_phone_num = "000-0000-0000"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("勤務先電話番号は入力しないでください")
          end
          it 'w_job_descriptionが入力されていても、swicth_owner_formの値が"C"の場合(所有形態が法人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.w_job_description = "テストの職業"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("仕事内容は入力しないでください")
          end
        end
      end
      context '👉 オーナーが法人の場合' do
        before do
          @property_owner_utility_equipment_facility = FactoryBot.build(:property_owner_utility_equipment_facility, :owner_swicth_is_company)
        end
        context "物件情報について" do
          it 'nameが空では登録できないこと' do
            @property_owner_utility_equipment_facility.name = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("物件名称を入力してください")
          end
          it 'name_kanaが空では登録できないこと' do
            @property_owner_utility_equipment_facility.name_kana = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("物件名称カナを入力してください")
          end
          it 'nama_kanaに全角カタカナではない文字列が含まれている場合登録できないこと' do
            @property_owner_utility_equipment_facility.name_kana = "あいうえおビル"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("物件名称カナは全角カタカナで入力してください")
          end
        end
        context "物件情所在地について" do
          it 'post_codeが空では登録できないこと' do
            @property_owner_utility_equipment_facility.post_code = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("郵便番号を入力してください")
          end
          it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと(全角伸ばし棒で検証)' do
            @property_owner_utility_equipment_facility.post_code = '123ー4567'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('郵便番号にハイフンを含め、000-0000の形式で入力してください')
          end
          it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと(ハイフンなしで検証)' do
            @property_owner_utility_equipment_facility.post_code = '1234567'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('郵便番号にハイフンを含め、000-0000の形式で入力してください')
          end
          it 'post_codeは ○ ○ ○ - ○ ○ ○ ○ という形で入力しないと登録できない( ○ は半角数字とする)' do
            @property_owner_utility_equipment_facility.post_code = '1234-567'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('郵便番号にハイフンを含め、000-0000の形式で入力してください')
          end
          it 'prefecture_idを選択していないと登録できない' do
            @property_owner_utility_equipment_facility.prefecture_id = 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("都道府県を選択してください")
          end
          it 'cityが空の場合には登録できない' do
            @property_owner_utility_equipment_facility.city = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("市区町村を入力してください")
          end
          it 'streetが空の場合には登録できない' do
            @property_owner_utility_equipment_facility.street = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("番地を入力してください")
          end
        end
        context "物件種別について" do
          it 'type_idを選択していない場合は登録できない' do
            @property_owner_utility_equipment_facility.type_id = 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("物件種別を選択してください")
          end
        end
        context "総戸数について" do
          it 'units1より少ない場合には登録できない' do
            @property_owner_utility_equipment_facility.units = 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("総戸数は1~3000の範囲内かつ、半角英数字で入力をしてください")
          end
          it 'unitsが3000より大きい場合には登録できない' do
            @property_owner_utility_equipment_facility.units = 3001
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("総戸数は1~3000の範囲内かつ、半角英数字で入力をしてください")
          end
          it 'unitsに半角数字以外が含まれている場合には登録できない' do
            # ※全角数字を打ち込む
            @property_owner_utility_equipment_facility.units = "１００"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("総戸数は1~3000の範囲内かつ、半角英数字で入力をしてください")
          end
        end
        context "管理形態について" do
          it 'management_form_idを選択していないと登録できない' do
            @property_owner_utility_equipment_facility.management_form_id= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("管理形態を選択してください")
          end
        end
        context "ライフラインについて" do
          it 'water_supply_idを選択していないと登録できない' do
            @property_owner_utility_equipment_facility.water_supply_id= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("上水道の選択が必要です")
          end
          it 'sewer_idを選択していないと登録できない' do
            @property_owner_utility_equipment_facility.sewer_id= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("下水道の選択が必要です")
          end
          it 'electrical_id,を選択していないと登録できない' do
            @property_owner_utility_equipment_facility.electrical_id,= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("電気の選択が必要です")
          end
          it 'ga_idを選択していないと登録できない' do
            @property_owner_utility_equipment_facility.ga_id= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("ガスの選択が必要です")
          end
        end
        context "物件写真登録について" do
          it 'imageが空の場合には登録できない' do
            @property_owner_utility_equipment_facility.image = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("物件画像を選択してください")
          end
        end
        context "物件ランクについて" do
          it 'rank_idを選択していないと登録できない' do
            @property_owner_utility_equipment_facility.rank_id= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("物件ランクを選択してください")
          end
        end
        context "所有者名称について(※swicth_owner_formの値はC)" do
          it 'swicth_owner_formが、空では登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = nil 
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("所有形態の選択が必要")
          end
          it 'swicth_owner_formの値が"H","C"以外の値が送信されてきた場合には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "Z"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("所有形態が異常な値です")
          end
          it 'owner_company_nameが、空では登録できない' do
            @property_owner_utility_equipment_facility.owner_company_name= nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("会社名を入力してください")
          end
          it 'owner_company_nameが入力されていても、swicth_owner_formの値が"H"の場合(所有形態が個人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "H"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("会社名は入力しないでください")
          end
          it 'owner_company_name_kanaが、空では登録できない' do
            @property_owner_utility_equipment_facility.owner_company_name_kana= nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("会社名カナを入力してください")
          end
          it 'owner_company_name_kanaが全角カタカナではない文字列が含まれている場合登録できないこと' do
            @property_owner_utility_equipment_facility.owner_company_name_kana = 'あ漢ｱ'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('会社名カナは全角カタカナで入力してください')
          end
          it 'owner_company_name_kanaが入力されていても、swicth_owner_formの値が"H"の場合(所有形態が個人を選択されている場合)には登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "H"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("会社名カナは入力しないでください")
          end
          it 'last_nameが空でないと登録できない' do
            @property_owner_utility_equipment_facility.last_name= Gimei.last.kanji
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("姓は入力しないでください")
          end
          it 'first_nameが空でないと登録できない' do
            @property_owner_utility_equipment_facility.first_name= Gimei.first.kanji
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("名は入力しないでください")
          end
          it 'last_name_kanaが空でないと登録できない' do
            @property_owner_utility_equipment_facility.last_name_kana= Gimei.last.katakana
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("姓(カナ)は入力しないでください")
          end
          it 'first_name_kanaが空でないと登録できない' do
            @property_owner_utility_equipment_facility.first_name_kana= Gimei.first.katakana
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("名(カナ)は入力しないでください")
          end
        end
        context "所有者について" do
          it 'genderは空でないと登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.gender = ["M","W"].sample
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("性別は入力しないでください")
          end
          it 'character_idが0が選択されていないと登録できない' do
            @property_owner_utility_equipment_facility.swicth_owner_form = "C"
            @property_owner_utility_equipment_facility.character_id = Faker::Number.between(from: 1, to: 3)
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("性格の選択は不要です")
          end
        end
        context "所有者住所について" do
          it 'owner_post_codeが空では登録できないこと' do
            @property_owner_utility_equipment_facility.owner_post_code= nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("郵便番号を入力してください")
          end
          it 'owner_post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと(全角伸ばし棒で検証)' do
            @property_owner_utility_equipment_facility.owner_post_code = '123ー4567'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('郵便番号にハイフンを含め、000-0000の形式で入力してください')
          end
          it 'owner_post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと(ハイフンなしで検証)' do
            @property_owner_utility_equipment_facility.owner_post_code = '1234567'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('郵便番号にハイフンを含め、000-0000の形式で入力してください')
          end
          it 'owner_post_codeは ○ ○ ○ - ○ ○ ○ ○ という形で入力しないと登録できない( ○ は半角数字とする)' do
            @property_owner_utility_equipment_facility.owner_post_code = '1234-567'
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include('郵便番号にハイフンを含め、000-0000の形式で入力してください')
          end
          it 'owner_prefecture_idが選択されていない場合は登録できないこと' do
            @property_owner_utility_equipment_facility.owner_prefecture_id= 0
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("都道府県を選択してください")
          end
          it 'owner_cityが空では登録できないこと' do
            @property_owner_utility_equipment_facility.owner_city= nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("市区町村を入力してください")
          end
          it 'owner_streetが、空では登録できないこと' do
            @property_owner_utility_equipment_facility.owner_street= nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("番地を入力してください")
          end
        end
        context "連絡先等について" do
          it 'main_communicationが空では登録できないこと' do
            @property_owner_utility_equipment_facility.main_communication = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("主要やり取り人物を入力してください")
          end
          it 'communication_aboutが空では登録できないこと' do
            @property_owner_utility_equipment_facility.communication_about = nil
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("やり取り方法についてを入力してください")
          end
        end
        context "勤務先情報について" do
          it 'w_company_nameが空でないと登録できない' do
            @property_owner_utility_equipment_facility.w_company_name = "テスト株式会社"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("会社名は入力しないでください")
          end
          it 'w_company_name_kanaが空でないと登録できない' do
            @property_owner_utility_equipment_facility.w_company_name_kana = "テストカブシキガイシャ"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("会社名(カナ)は入力しないでください")
          end
          it 'w_post_codeが空でないと登録できない' do
            @property_owner_utility_equipment_facility.w_post_code = "123-1234"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("郵便番号は入力しないでください")
          end
          it 'w_prefecture_idが空でないと登録できない' do
            @property_owner_utility_equipment_facility.w_prefecture_id = 1
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("都道府県の選択は不要です")
          end
          it 'w_cityが空でないと登録できない' do
            @property_owner_utility_equipment_facility.w_city= "東京都渋谷区渋谷"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("市区町村は入力しないでください")
          end
          it 'w_streetが空でないと登録できない' do
            @property_owner_utility_equipment_facility.w_street = "１−１−１"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("番地は入力しないでください")
          end
          it 'w_building_nameが空でないと登録できない' do
            @property_owner_utility_equipment_facility.w_building_name = "テストアパート101"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("建物名は入力しないでください")
          end
          it 'w_company_phone_numが空でないと登録できない' do
            @property_owner_utility_equipment_facility.w_company_phone_num = "000-0000-0000"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("勤務先電話番号は入力しないでください")
          end
          it 'w_job_descriptionが空でないと登録できない' do
            @property_owner_utility_equipment_facility.w_job_description = "テスト"
            @property_owner_utility_equipment_facility.valid?
            expect(@property_owner_utility_equipment_facility.errors.full_messages).to include("仕事内容は入力しないでください")
          end
        end
      end
    end
  end
end