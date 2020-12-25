# == Schema Information
#
# Table name: owners
#
#  id                  :bigint           not null, primary key
#  building_name       :string(255)
#  character_about     :text(65535)
#  city                :string(255)      not null
#  communication_about :text(65535)      not null
#  company_name        :string(255)
#  company_name_kana   :string(255)
#  email               :string(255)
#  fax_num             :string(255)
#  first_name          :string(255)
#  first_name_kana     :string(255)
#  gender              :string(255)      default("M")
#  home_phone_num      :string(255)
#  last_name           :string(255)
#  last_name_kana      :string(255)
#  main_communication  :string(255)      not null
#  other_phone_num     :string(255)
#  phone_num           :string(255)
#  post_code           :string(255)      not null
#  street              :string(255)      not null
#  swicth_owner_form   :string(255)      default("H"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  character_id        :integer
#  prefecture_id       :integer          not null
#
require 'rails_helper'

RSpec.describe Owner, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
