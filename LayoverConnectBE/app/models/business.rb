class Business < ActiveRecord::Base
  belongs_to :terminal
  has_many :appointments
  has_many :users, through: :appointments
end

