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
class Resource < ApplicationRecord
end
