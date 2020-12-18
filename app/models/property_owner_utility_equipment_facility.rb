class PropertyOwnerUtilityEquipmentFacility
  include ActiveModel::Model
  attr_accessor :name, :name_kana, :post_code, :prefecture_id, :city, :street, :type_id, :units, :management_form_id, :rank_id, :caution, :image, :company_id, :worker_id, :swicth_owner_form, :owner_company_name, :owner_company_name_kana, :last_name, :first_name, :last_name_kana, :first_name_kana, :gender, :character_id, :character_about, :owner_post_code, :owner_prefecture_id, :owner_city, :owner_street, :owner_building_name, :main_communication, :communication_about, :home_phone_num, :phone_num, :other_phone_num, :fax_num, :email, :w_company_name, :w_company_name_kana, :w_post_code, :w_prefecture_id, :w_city, :w_street, :w_building_name, :w_company_phone_num, :w_job_description, :water_supply_id, :sewer_id, :electrical_id, :ga_id, :equipment_id, :facility_id

  with_options presence: true do
    # Properties(物件情報のバリデーション)
    validates :name
    validates :name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'にハイフンを含め、000-0000の形式で入力してください' }
    validates :prefecture_id, numericality: { other_than: 0, message: "を選択してください" }
    validates :city
    validates :street
    validates :type_id, numericality: { other_than: 0, message: "を選択してください" }
    validates :units, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3000,message: 'は1~3000の範囲内で入力が必要です'}, format: { with: /\A[0-9]+\z/ }
    validates :management_form_id, numericality: { other_than: 0, message: "を選択してください" }
    validates :image
    validates :rank_id, numericality: { other_than: 0, message: "を選択してください" }
    # Owners(所有者情報のバリデーション)
    validates :owner_post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'にハイフンを含め、000-0000の形式で入力してください' }
    validates :owner_prefecture_id, numericality: { other_than: 0, message: "を選択してください" }
    validates :owner_city
    validates :owner_street
    validates :main_communication
    validates :communication_about
    # Utility(ライフライン情報のバリデーション)
    validates :water_supply_id, numericality: { other_than: 0, message: "の選択が必要です" }
    validates :sewer_id, numericality: { other_than: 0, message: "の選択が必要です" }
    validates :electrical_id, numericality: { other_than: 0, message: "の選択が必要です" }
    validates :ga_id, numericality: { other_than: 0, message: "の選択が必要です" }
  end

  # owner
  validates :swicth_owner_form, presence: { message: "を選択が必要" }
  validates :owner_company_name, presence: true, if: :swicth_owner_form_is_company?
  validates :owner_company_name_kana,presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }, if: :swicth_owner_form_is_company?
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角ひらがな、全角カタカナ、漢字のいずれかで入力してください' }, if: :swicth_owner_form_is_human?
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角ひらがな、全角カタカナ、漢字のいずれかで入力してください' }, if: :swicth_owner_form_is_human?
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }, if: :swicth_owner_form_is_human?
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }, if: :swicth_owner_form_is_human?

  def save
    owner = Owner.create(swicth_owner_form: swicth_owner_form, company_name: owner_company_name, company_name_kana: owner_company_name_kana, last_name: last_name, first_name: first_name, last_name_kana: last_name_kana, first_name_kana: first_name_kana, gender: gender, character_id: character_id, character_about: character_about, post_code: owner_post_code, prefecture_id: owner_prefecture_id, city: owner_city, street: owner_street, building_name: owner_building_name, main_communication: main_communication, communication_about: communication_about, home_phone_num: home_phone_num, phone_num: phone_num, other_phone_num: other_phone_num, fax_num: fax_num, email: email)
    property = Property.create(name: name, name_kana: name_kana, post_code: post_code, prefecture_id: prefecture_id, city: city, street: street, type_id: type_id, units: units, management_form_id: management_form_id, rank_id: rank_id, caution: caution, image: image,company_id: company_id, worker_id: worker_id, owner_id: owner.id)
    OwnerWorkCompany.create(company_name: w_company_name, company_name_kana: w_company_name_kana, post_code: w_post_code, prefecture_id: w_prefecture_id, city: w_city, street: w_street, building_name: w_building_name, company_phone_num: w_company_phone_num, job_description: w_job_description, owner_id: owner.id)
    Utility.create(water_supply_id: water_supply_id, sewer_id: sewer_id, electrical_id: electrical_id, ga_id: ga_id, property_id: property.id)
  end

  def swicth_owner_form_is_company?
    swicth_owner_form == "true"
  end

  def swicth_owner_form_is_human?
    swicth_owner_form == "false"
  end

end