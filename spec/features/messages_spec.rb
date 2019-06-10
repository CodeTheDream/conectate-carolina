require 'rails_helper'

RSpec.feature "Messages", type: :feature, js: true do
  let!(:message) { create :message, title: "Alert!" }

  scenario "user sees message" do
    visit root_path(locale: 'en')
    expect(page).to have_content "Alert!"
    click_button('my_button')
    expect(page).to_not have_content "Alert!"
  end
end
