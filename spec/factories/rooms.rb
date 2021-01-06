# == Schema Information
#
# Table name: rooms
#
#  id              :bigint           not null, primary key
#  floor           :integer          not null
#  key_place       :string(255)
#  mail_num        :string(255)
#  management_form :string(255)      default("O"), not null
#  room_num        :string(255)
#  room_status     :string(255)      default("V"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  property_id     :bigint
#
# Indexes
#
#  index_rooms_on_property_id  (property_id)
#
FactoryBot.define do
  factory :room do
    room_num{Faker::Number.between(from: 1, to: 999)}
    management_form{["0","M","S","N"].sample}
    floor{Faker::Number.between(from: 1, to: 99)}
    room_status{["V","M"].sample}
  end
end
