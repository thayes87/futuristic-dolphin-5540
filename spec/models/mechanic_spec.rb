require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'relationships' do
    it { should have_many(:mechanic_rides) }
    it { should have_many(:rides).through(:mechanic_rides) }
  end

  describe "class methods" do
    describe "#self.average_years_of_experience" do
      it 'returns average years of experience for mechanics' do
        tom = Mechanic.create!(name: "Tom", years_experience: 10)
        zach = Mechanic.create!(name: "Zach", years_experience: 9)
        alex = Mechanic.create!(name: "Alex", years_experience: 8)

        expect(Mechanic.average_years_of_experience).to eq(9)
      end
    end
  end
  
  describe 'instance methods' do
    describe "#open_rides"do
      it 'returns only rides with an open status' do
        @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

        @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
        @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
        @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 2, open: false)
        @tea_cup = @six_flags.rides.create!(name: 'Tea Cup', thrill_rating: 3, open: true)

        @tom = Mechanic.create!(name: "Tom", years_experience: 10)
        
        MechanicRide.create!(mechanic_id: @tom.id, ride_id: @hurler.id)
        MechanicRide.create!(mechanic_id: @tom.id, ride_id: @scrambler.id)
        MechanicRide.create!(mechanic_id: @tom.id, ride_id: @ferris.id)
        MechanicRide.create!(mechanic_id: @tom.id, ride_id: @tea_cup.id)
        
        expect(@tom.open_rides).to eq([@hurler, @scrambler, @tea_cup])
      end
    end

    describe "#sort_by_thrills" do
      it 'returns rides in order of thrill rating: highest to lowest' do
        @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

        @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
        @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
        @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 2, open: false)
        @tea_cup = @six_flags.rides.create!(name: 'Tea Cup', thrill_rating: 3, open: true)

        @tom = Mechanic.create!(name: "Tom", years_experience: 10)

        MechanicRide.create!(mechanic_id: @tom.id, ride_id: @hurler.id)
        MechanicRide.create!(mechanic_id: @tom.id, ride_id: @scrambler.id)
        MechanicRide.create!(mechanic_id: @tom.id, ride_id: @ferris.id)
        MechanicRide.create!(mechanic_id: @tom.id, ride_id: @tea_cup.id)

        sorted = @tom.sort_by_thrill
        expect(sorted.first).to eq(@hurler)
        expect(sorted.second).to eq(@scrambler)
        expect(sorted.third).to eq(@tea_cup)
      end
    end
  end
end