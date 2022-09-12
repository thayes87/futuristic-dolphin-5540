class MechanicsController < ApplicationController
  def index
    @mechanics = Mechanic.all
  end

  def show
    @mechanic = Mechanic.find(params[:id])
    @open_rides = @mechanic.rides.where(open: true)
    @display_rides = @open_rides.order("thrill_rating DESC")
  end

  def update
    @mechanic = Mechanic.find(params[:id])
    ride = Ride.find(params[:ride_id])
    @mechanic.rides << ride
    redirect_to "/mechanics/#{@mechanic.id}"
  end
end