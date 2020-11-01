class Worker < ApplicationRecord
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
          validates :last_name
          validates :first_name
          validates :last_name_kana
          validates :first_name_kana
          validates :gender
          validates :character
          validates :position
          validates :born
          validates :qualification
        end

         def email_required?
          false
        end
        
        def email_changed?
          false
        end
end
