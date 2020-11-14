class Property < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :equipment
  belongs_to_active_hash :facility
  serialize :equipment
  serialize :facility
  # has_many :rooms
  # has_many :traffics
  # has_many :car_parks, through: property_car_parks 
  has_one :utility
  belongs_to :company
  belongs_to :worker
  belongs_to :owner
  has_one_attached :image
end
