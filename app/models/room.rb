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
class Room < ApplicationRecord
  belongs_to :property

  with_options presence: true do
    validates :room_num
    validates :floor, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 99,message: 'は1~99の範囲内かつ、半角英数字で入力をしてください'}, format: { with: /\A[0-9]+\z/ }
  end

  validates :management_form, inclusion: { in: %w(O M S N), message: "が異常な値です" }, if: :management_form
  validates :room_status, inclusion: { in: %w(V M), message: "が異常な値です" }, if: :room_status
end
