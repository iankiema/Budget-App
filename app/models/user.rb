class User < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :expenditures, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true,
                        length: { maximum: 25, too_long: '%<count>s charecters is the maximum allowed' }
  validates :email, presence: true, uniqueness: true
end
