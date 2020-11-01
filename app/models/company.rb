class Company < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :workers
  has_one_attached :image
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :name
    validates :image
    validates :company_login_id, format: { with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/, message: "は半角6~12文字かつ英大文字・小文字・数字それぞれ１文字以上を含む必要があります"},uniqueness: true
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :street
    validates :email,uniqueness: true
  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:company_login_id] 

         def email_required?
          false
        end
        
        def email_changed?
          false
        end
end
