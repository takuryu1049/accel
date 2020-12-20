class PropertyOwnerUtilityEquipmentFacility
  include ActiveModel::Model
  attr_accessor :name, :name_kana, :post_code, :prefecture_id, :city, :street, :type_id, :units, :management_form_id, :rank_id, :caution, :image, :company_id, :worker_id, :swicth_owner_form, :owner_company_name, :owner_company_name_kana, :last_name, :first_name, :last_name_kana, :first_name_kana, :gender, :character_id, :character_about, :owner_post_code, :owner_prefecture_id, :owner_city, :owner_street, :owner_building_name, :main_communication, :communication_about, :home_phone_num, :phone_num, :other_phone_num, :fax_num, :email, :w_company_name, :w_company_name_kana, :w_post_code, :w_prefecture_id, :w_city, :w_street, :w_building_name, :w_company_phone_num, :w_job_description, :water_supply_id, :sewer_id, :electrical_id, :ga_id, :equipment_id, :facility_id

  # 物件名称について 👈
  with_options presence: true do
    validates :name
    validates :name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }
  end

  # 物件所在地について 👈
  with_options presence: true do
    validates :post_code, 
    format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'にハイフンを含め、000-0000の形式で入力してください' }
    validates :prefecture_id, 
    numericality: { other_than: 0, message: "を選択してください" }
    validates :city
    validates :street
  end

  # 物件種別について 👈
  with_options presence: true do
    validates :type_id, numericality: { other_than: 0, message: "を選択してください" }
  end

  # 総戸数について 👈
  with_options presence: true do
    validates :units, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3000,message: 'は1~3000の範囲内かつ、半角英数字で入力をしてください'}, format: { with: /\A[0-9]+\z/ }
  end

  # 管理形態について 👈
  with_options presence: true do
    validates :management_form_id, numericality: { other_than: 0, message: "を選択してください" }
  end

  # ライフラインについて 👈
  with_options presence: true do
    validates :water_supply_id, numericality: { other_than: 0, message: "の選択が必要です" }
    validates :sewer_id, numericality: { other_than: 0, message: "の選択が必要です" }
    validates :electrical_id, numericality: { other_than: 0, message: "の選択が必要です" }
    validates :ga_id, numericality: { other_than: 0, message: "の選択が必要です" }
  end

  # 物件写真登録について 👈
  with_options presence: true do
    validates :image, presence: { message: "を選択してください" }
  end

  # 物件ランクについて 👈
  with_options presence: true do
    validates :rank_id, numericality: { other_than: 0, message: "を選択してください" }
  end

  # 所有者名称について 👈

  # 共通の項目
  validates :swicth_owner_form, presence: { message: "の選択が必要" }
  # 個人と、法人のみを識別する値のみしか受け付けないようにするバリデーション
  validates :swicth_owner_form, inclusion: { in: %w(H C), message: "が異常な値です" }

  # 所有形態で個人が選択された場合
  with_options if: :swicth_owner_form_is_human? do
    # 姓、名、姓(カナ),名(カナ)を入力しなければいけない
    validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角ひらがな、全角カタカナ、漢字のいずれかで入力してください' }
    validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角ひらがな、全角カタカナ、漢字のいずれかで入力してください' }
    validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }
    validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }
    # 会社名、会社名(カナ)は、登録することができなくなる
    validates :owner_company_name, absence: true
    validates :owner_company_name_kana, absence: true
  end

  # 所有形態で法人が選択された場合
  with_options if: :swicth_owner_form_is_company? do
    # 会社名、会社名(カナ)を入力しなければいけない
    validates :owner_company_name, presence: true
    validates :owner_company_name_kana,presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }

    # 姓、名、姓(カナ)、名(カナ)、性別、性格
    validates :last_name, absence: true, if: :swicth_owner_form_is_company?
    validates :first_name, absence: true, if: :swicth_owner_form_is_company?
    validates :last_name_kana, absence: true, if: :swicth_owner_form_is_company?
    validates :first_name_kana, absence: true, if: :swicth_owner_form_is_company?
  end

  # 所有者について 👈
  # 任意の値ではあるが、M,W以外の値が送信されてきた時のバリデーション
  validates :gender, inclusion: { in: %w(M W), message: "が異常な値です" }, if: :gender
  # 所有形態で法人が選択された場合、性別と、性格は空の状態でないと登録できなくなる
  with_options if: :swicth_owner_form_is_company? do
    validates :gender, absence: true
    validates :character_id, numericality: { equal_to: 0, message: "の選択は不要です"}
  end
  
  # 所有者住所について 👈
  with_options presence: true do
    validates :owner_post_code,
      format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'にハイフンを含め、000-0000の形式で入力してください' }
    validates :owner_prefecture_id,
      numericality: { other_than: 0, message: "を選択してください" }
    validates :owner_city
    validates :owner_street
  end

  # 連絡先等について 👈
  with_options presence: true do
    validates :main_communication
    validates :communication_about
  end

  # 勤務先情報について 👈
  # 所有形態で法人が選択された場合は勤務先情報の会社名、会社名(カナ)、郵便番号、都道府県、市区町村、番地、建物名、勤務先電話番号、仕事内容は、空の状態でないと登録できなくなる
  with_options if: :swicth_owner_form_is_company? do
    validates :w_company_name, absence: true
    validates :w_company_name_kana, absence: true
    validates :w_post_code, absence: true
    validates :w_prefecture_id, absence: true
    validates :w_city, absence: true
    validates :w_street, absence: true
    validates :w_building_name, absence: true
    validates :w_company_phone_num, absence: true
    validates :w_job_description, absence: true
  end

  def save
    owner = Owner.create(swicth_owner_form: swicth_owner_form, company_name: owner_company_name, company_name_kana: owner_company_name_kana, last_name: last_name, first_name: first_name, last_name_kana: last_name_kana, first_name_kana: first_name_kana, gender: gender, character_id: character_id, character_about: character_about, post_code: owner_post_code, prefecture_id: owner_prefecture_id, city: owner_city, street: owner_street, building_name: owner_building_name, main_communication: main_communication, communication_about: communication_about, home_phone_num: home_phone_num, phone_num: phone_num, other_phone_num: other_phone_num, fax_num: fax_num, email: email)
    property = Property.create(name: name, name_kana: name_kana, post_code: post_code, prefecture_id: prefecture_id, city: city, street: street, type_id: type_id, units: units, management_form_id: management_form_id, rank_id: rank_id, caution: caution, image: image,company_id: company_id, worker_id: worker_id, owner_id: owner.id)
    OwnerWorkCompany.create(company_name: w_company_name, company_name_kana: w_company_name_kana, post_code: w_post_code, prefecture_id: w_prefecture_id, city: w_city, street: w_street, building_name: w_building_name, company_phone_num: w_company_phone_num, job_description: w_job_description, owner_id: owner.id)
    Utility.create(water_supply_id: water_supply_id, sewer_id: sewer_id, electrical_id: electrical_id, ga_id: ga_id, property_id: property.id)
  end

  
  def swicth_owner_form_is_human?
    swicth_owner_form == "H"
  end
  
  def swicth_owner_form_is_company?
    swicth_owner_form == "C"
  end
end