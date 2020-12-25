# == Schema Information
#
# Table name: workers
#
#  id                     :bigint           not null, primary key
#  born                   :date             not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)      not null
#  first_name_kana        :string(255)      not null
#  gender                 :boolean          default(FALSE), not null
#  last_name              :string(255)      not null
#  last_name_kana         :string(255)      not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  character_id           :integer          not null
#  company_id             :bigint           not null
#  position_id            :integer          not null
#  qualification_id       :integer
#  worker_login_id        :string(255)      not null
#
# Indexes
#
#  index_workers_on_company_id            (company_id)
#  index_workers_on_email                 (email) UNIQUE
#  index_workers_on_reset_password_token  (reset_password_token) UNIQUE
#  index_workers_on_worker_login_id       (worker_login_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Worker < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :company
  has_one_attached :image
  belongs_to_active_hash :character
  belongs_to_active_hash :position
  belongs_to_active_hash :qualification
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:worker_login_id]

  with_options presence: true do
    validates :worker_login_id, format: { with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/, message: 'は半角6~12文字かつ英大文字・小文字・数字それぞれ１文字以上を含むように入力してください' }, uniqueness: true
    validates :image
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角ひらがな、全角カタカナ、漢字のいずれかで入力してください' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角ひらがな、全角カタカナ、漢字でのいずれかで入力してください' }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }
    validates :character_id, numericality: { other_than: 0, message: "を選択してください" }
    validates :position_id, numericality: { other_than: 0, message: "を選択してください" }
    validates :born
    validates :email, uniqueness: true
  end

  validates :gender, inclusion: { in: [true, false], message: 'を選択してください'}

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
