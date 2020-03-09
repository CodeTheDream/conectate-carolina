require 'rails_helper'

RSpec.feature "Messages", type: :feature, js: true do
  let!(:message) { create :message, title: "Alert!" }
  let!(:admin) { create :user, :admin, email: "admin@example.com", password: "foobar"}
  let!(:user_message) { create :message, posted: false, posted_at: Time.now }

  scenario "user sees message" do
    visit root_path(locale: 'en')
    expect(page).to have_text "Alert!"
    click_button 'my_x_button'
    expect(page).to_not have_text "Alert!"
  end

  scenario "hides alert flash message when visitor clicks `X` icon" do
    visit root_path(locale: 'en')
    click_button 'my_x_button' #hides message
    # click_link 'my_icon_link'   #displays user_messages
    expect(page).to have_text "Alerts"
  end

  scenario "displays list of messages" do
    signin('admin@example.com', 'foobar')
    visit root_path(locale: 'en')
    expect(page).to have_text('Messages') #actually wanted to test as a link (`have_link`)
    click_link 'my_messages_link' #redirects to message index page
    expect(page).to have_text "Message Center"
  end

end
