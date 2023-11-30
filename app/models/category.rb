class Category < ApplicationRecord
  belongs_to :user
  has_many :expenditures, dependent: :destroy

  validates :name, presence: true, length: { maximum: 25, too_long: '%<count>s charecters is the maximum allowed' }
  validates :icon, presence: true
end
