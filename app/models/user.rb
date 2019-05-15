class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products
  validates :name, presence: { message: 'User must have a name'}
  validates :email, presence: { message: 'User must have an email'}
  # validate :validate_age, if: proc { |u| u.birthday.present? }

  ACCESS_LEVEL = %i[user admin super_admin]
  enum access_level: ACCESS_LEVEL

   private

  def validate_age
    return if valid_date_range.include?(birthday)
    errors.add(:birthday, 'invalid. Must be 12-100 years of age')
  end

  def valid_date_range
    maximum_date..minimum_date
  end

  def minimum_date
    12.years.ago.to_date
  end

  def maximum_date
    100.years.ago.to_date
  end

end
