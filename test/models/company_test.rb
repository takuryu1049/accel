# == Schema Information
#
# Table name: companies
#
#  id                     :bigint           not null, primary key
#  building_name          :string(255)
#  city                   :string(255)      not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)      not null
#  post_code              :string(255)      not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  street                 :string(255)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_login_id       :string(255)      not null
#  prefecture_id          :integer          not null
#
# Indexes
#
#  index_companies_on_company_login_id      (company_login_id) UNIQUE
#  index_companies_on_email                 (email) UNIQUE
#  index_companies_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
