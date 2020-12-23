# == Schema Information
#
# Table name: resources
#
#  id            :bigint           not null, primary key
#  ad_fee        :integer          not null
#  brokerage_fee :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Resource, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
