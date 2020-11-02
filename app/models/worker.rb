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
         :recoverable, :rememberable, :validatable, :authentication_keys => [:worker_login_id] 

         with_options presence: true do
          validates :worker_login_id, format: { with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/, message: "は半角6~12文字かつ英大文字・小文字・数字それぞれ１文字以上を含む必要があります"},uniqueness: true
          validates :image
          validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: '全角ひらがな、全角カタカナ、漢字で入力必要(名前(全角)/苗字)' }
          validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: '全角ひらがな、全角カタカナ、漢字で入力必要(名前(全角)/名前)' }
          validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナで入力必要(名前カナ(全角)/苗字)' }
          validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナで入力必要(名前カナ(全角)/名前)' }
          validates :character_id, numericality: { other_than: 0, message: "can't be blank" }
          validates :position_id, numericality: { other_than: 0, message: "can't be blank" }
          validates :born
          validates :email,uniqueness: true
        end

        validates :gender, inclusion: { in: [true, false] }

        def email_required?
          false
        end
        
        def email_changed?
          false
        end
end
