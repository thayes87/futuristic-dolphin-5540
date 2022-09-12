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
end