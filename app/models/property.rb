# == Schema Information
#
# Table name: properties
#
#  id                 :bigint           not null, primary key
#  caution            :text(65535)
#  city               :string(255)      not null
#  name               :string(255)      not null
#  name_kana          :string(255)      not null
#  post_code          :string(255)      not null
#  street             :string(255)      not null
#  units              :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  company_id         :bigint           not null
#  management_form_id :integer          not null
#  owner_id           :bigint           not null
#  prefecture_id      :integer          not null
#  rank_id            :integer          not null
#  type_id            :integer          not null
#  worker_id          :bigint           not null
#
# Indexes
#
#  index_properties_on_company_id  (company_id)
#  index_properties_on_owner_id    (owner_id)
#  index_properties_on_worker_id   (worker_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (owner_id => owners.id)
#  fk_rails_...  (worker_id => workers.id)
#
class Property < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :type
  belongs_to_active_hash :management_form
  belongs_to_active_hash :rank
  has_many :rooms
  # has_many :traffics
  # has_many :car_parks, through: property_car_parks 
  has_one :utility
  belongs_to :company
  belongs_to :worker
  belongs_to :owner
  has_one_attached :image
end
