# == Schema Information
#
# Table name: utilities
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  electrical_id   :integer          not null
#  ga_id           :integer          not null
#  property_id     :bigint           not null
#  sewer_id        :integer          not null
#  water_supply_id :integer          not null
#
# Indexes
#
#  index_utilities_on_property_id  (property_id)
#
# Foreign Keys
#
#  fk_rails_...  (property_id => properties.id)
#
FactoryBot.define do
  factory :utility do
    
  end
end
