require 'rails_helper'

RSpec.feature 'ChangeColours', type: :feature, js: true do
  scenario 'click change colour button' do
    visit '/'
    click_on "Manage Pharmacies"
    expect(page).not_to have_css('invisible')    
    click_button 'Click to change colour'
    expect(page).to have_content 'Hi there. The button has been clicked!'
    expect(page).not_to have_css('invisible')
  end
end
