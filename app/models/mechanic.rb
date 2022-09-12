class Mechanic < ApplicationRecord
  has_many :mechanic_rides
  has_many :rides, through: :mechanic_rides

  def self.average_years_of_experience
    Mechanic.average(:years_experience)
  end
end