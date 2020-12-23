# == Schema Information
#
# Table name: companies
#
#  id                     :bigint           not null, primary key
#  building_name          :string(255)
#  city                   :string(255)      not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)      not null
#  post_code              :string(255)      not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  street                 :string(255)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_login_id       :string(255)      not null
#  prefecture_id          :integer          not null
#
# Indexes
#
#  index_companies_on_company_login_id      (company_login_id) UNIQUE
#  index_companies_on_email                 (email) UNIQUE
#  index_companies_on_reset_password_token  (reset_password_token) UNIQUE
#
class Company < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :workers
  has_many :properties
  has_one_attached :image
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :name
    validates :image
    validates :company_login_id, format: { with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/, message: 'は半角6~12文字かつ英大文字・小文字・数字それぞれ１文字以上を含むように入力してください' }, uniqueness: true
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'にハイフンが含まれていません' }
    validates :prefecture_id, numericality: { other_than: 0, message: "を選択してください" }
    validates :city
    validates :street
    validates :email, uniqueness: true
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:company_login_id]

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
