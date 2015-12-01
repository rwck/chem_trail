require 'rails_helper'

# This is the same as what is below
# RSpec.feature 'Manage pharmacy database', type: :feature, js: true do
#

feature 'Manage pharmacy database',
  """
  In order ot keep accurate information on pharmacy oopening hours
  As a pseudo junkie
  I want to be avble to read and update the information I keep""", js: true do

  # background do - this is an RSpec thing copied from Cucumber - it lets up a backstory
  # end

  background do
    visit '/'
    click_on "Manage Pharmacies"
  end

  # before(:each) do
  # end

  # end
  # pending "add some scenarios (or delete) #{__FILE__}"
  scenario 'Create a pharmacy' do
    # visit '/pharmacies' # go to this part of your rails app
    click_on 'New Pharmacy' # find a button or a link that has this label and then visit the thing that that has an href to
    fill_in 'Name', with: 'Ultimo Chemist Plus'
    sleep 0.5

    click_on "Add an open period"
    fill_in 'Day', with: "Thursday"
    sleep 0.5

    fill_in "Time from", with: '09:00 am'
    sleep 0.5

    fill_in "Time to", with: '08:00 pm'
    sleep 0.5

    click_on 'Create Pharmacy'
    expect(page).to have_content 'Pharmacy was successfully created'
    click_on 'Back'
    expect(page).to have_content 'Ultimo Chemist Plus'

    within('tr', text: "Ultimo Chemist Plus") do
      click_on "Show"
    end

    expect(page).to have_content "Thursday: 9:00 AM - 8:00 PM"

  end
end
