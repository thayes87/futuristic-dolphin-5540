class Mechanic < ApplicationRecord
  has_many :mechanic_rides
  has_many :rides, through: :mechanic_rides

  def self.average_years_of_experience
    average(:years_experience).round
  end

  def open_rides
    rides.where(open: true)
  end

  def sort_by_thrill
    open_rides.order("thrill_rating DESC")
  end
end