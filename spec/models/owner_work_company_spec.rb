# == Schema Information
#
# Table name: owner_work_companies
#
#  id                :bigint           not null, primary key
#  building_name     :string(255)
#  city              :string(255)
#  company_name      :string(255)
#  company_name_kana :string(255)
#  company_phone_num :string(255)
#  job_description   :string(255)
#  post_code         :string(255)
#  street            :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  owner_id          :bigint           not null
#  prefecture_id     :integer
#
# Indexes
#
#  index_owner_work_companies_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => owners.id)
#
require 'rails_helper'

RSpec.describe OwnerWorkCompany, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
