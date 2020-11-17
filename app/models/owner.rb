class Owner < ApplicationRecord
  has_many :properties
  has_many :relation_persons
  has_many :banks
  has_one :owner_work_company
end
