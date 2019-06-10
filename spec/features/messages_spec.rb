require 'rails_helper'

RSpec.feature "Messages", type: :feature, js: true do
  let!(:message) { create :message, title: "Alert!" }

  scenario "user sees message" do
    visit root_path(locale: 'en')
    expect(page).to have_text "Alert!"
    click_button 'my_x_button'
    expect(page).to_not have_text "Alert!"
  end

  scenario "displays message when user clicks `bell` icon" do
    visit root_path(locale: 'en')
    click_button 'my_x_button' #hides message
    click_link 'my_icon_link'   #re-displays message
    expect(page).to have_text "Alert!"
  end

end
