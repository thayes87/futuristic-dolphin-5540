require 'rails_helper'

# As a user,
# When I visit a mechanic show page
# I see their name, years of experience, and the names of rides they’re working on
# And I only see rides that are open
# And the rides are listed by thrill rating in descending order (most thrills first)
RSpec.describe 'the mechanics show page' do
  describe 'As a user, When I visit the mechanics show page' do
    it "has the mechanics names and their years of experience" do
      @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

      @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
      @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
      @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 2, open: false)
      @tea_cup = @six_flags.rides.create!(name: 'Tea Cup', thrill_rating: 3, open: true)
      
      @tom = Mechanic.create!(name: "Tom", years_experience: 10)
      @zach = Mechanic.create!(name: "Zach", years_experience: 9)

      MechanicRide.create!(mechanic_id: @tom.id, ride_id: @hurler.id)
      MechanicRide.create!(mechanic_id: @tom.id, ride_id: @scrambler.id)
      MechanicRide.create!(mechanic_id: @tom.id, ride_id: @ferris.id)
      MechanicRide.create!(mechanic_id: @tom.id, ride_id: @tea_cup.id)

      visit "/mechanics/#{@tom.id}"

      expect(page).to have_content("Name: Tom")
      expect(page).to have_content("Years of Experience: 10")
      expect(page).to_not have_content("Name: Zach")
      expect(page).to_not have_content("Years of Experience: 9")

      within "#Rides" do
        expect(page).to have_content("Name: The Hurler")
        expect(page).to have_content("Name: The Scrambler")
        expect(page).to have_content("Name: Tea Cup")
        expect(page).to_not have_content("Name: Ferris Wheel")

        expect('The Hurler').to appear_before('The Scrambler')
        expect('The Scrambler').to appear_before('Tea Cup')
      end
    end
  end
  describe 'As a user I can add rides to a mechanics workload' do
    it 'has a form to add an exisitng ride to a mechanic' do 
      @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

      @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
      @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
      @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 2, open: false)
      @tea_cup = @six_flags.rides.create!(name: 'Tea Cup', thrill_rating: 3, open: true)
      
      @tom = Mechanic.create!(name: "Tom", years_experience: 10)
      @zach = Mechanic.create!(name: "Zach", years_experience: 9)

      MechanicRide.create!(mechanic_id: @tom.id, ride_id: @hurler.id)
      MechanicRide.create!(mechanic_id: @tom.id, ride_id: @scrambler.id)
      MechanicRide.create!(mechanic_id: @tom.id, ride_id: @ferris.id)
  
      visit "/mechanics/#{@tom.id}"

      expect(page).to have_content("Ride ID")
      fill_in("Ride ID", with: "#{@tea_cup.id}")

      click_on("Submit")
      expect(current_path).to eq("/mechanics/#{@tom.id}")

      within "#Rides" do
        expect(page).to have_content("Name: The Hurler")
        expect(page).to have_content("Name: The Scrambler")
        expect(page).to have_content("Name: Tea Cup")
        expect(page).to_not have_content("Name: Ferris Wheel")
      end 
    end
  end
end 