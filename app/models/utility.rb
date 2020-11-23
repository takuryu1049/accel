class Utility < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :property
  belongs_to_active_hash :water_supply
  belongs_to_active_hash :sewer
  belongs_to_active_hash :electrical
  belongs_to_active_hash :ga
end
