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
require 'rails_helper'

RSpec.describe Room, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
