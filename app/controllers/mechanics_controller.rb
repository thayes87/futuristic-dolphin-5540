class MechanicsController < ApplicationController
  def index
    @mechanics = Mechanic.all
  end

  def show
    @mechanic = Mechanic.find(params[:id])
    @open_rides = @mechanic.rides.where(open: true)
    @display_rides = @open_rides.order("thrill_rating DESC")
  end
end