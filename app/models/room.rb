# == Schema Information
#
# Table name: rooms
#
#  id          :bigint           not null, primary key
#  floor       :integer
#  room_num    :string(255)
#  room_status :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  property_id :bigint
#
# Indexes
#
#  index_rooms_on_property_id  (property_id)
#
class Room < ApplicationRecord
  belongs_to :property
end
