class Vessel < ApplicationRecord
  belongs_to :user
  has_many :operations, dependent: :destroy
  has_many :reports, dependent: :destroy
end
