class Owner < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :character
  belongs_to_active_hash :prefecture
  has_many :properties
  has_many :relation_persons
  has_many :banks
  has_one :owner_work_company
end
