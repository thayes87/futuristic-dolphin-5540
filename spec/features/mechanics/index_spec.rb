require 'rails_helper'

RSpec.describe 'the mechanics index page' do
  describe 'As a user, When I visit the mechanics index page' do
    it "has a list of all mechanics names and their years of expperience" do
      tom = Mechanic.create!(name: "Tom", years_experience: 11)
      zach = Mechanic.create!(name: "Zach", years_experience: 9)
      alex = Mechanic.create!(name: "Alex", years_experience: 5)
      
      visit '/mechanics'

      expect(page).to have_content("All Mechanics")

      within "#Mechanics" do
        expect(page).to have_content("Name: Tom")
        expect(page).to have_content("Years of Experience: 11")
        expect(page).to have_content("Name: Zach")
        expect(page).to have_content("Years of Experience: 9")
        expect(page).to have_content("Name: Alex")
        expect(page).to have_content("Years of Experience: 5")
      end 
    end
  end
end 



# As a user,
# When I visit the mechanics index page
# I see a header saying “All Mechanics”
# And I see a list of all mechanic’s names and their years of experience
# And I see the average years of experience across all mechanics