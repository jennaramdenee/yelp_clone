require 'rails_helper'

feature 'reviewing' do
  include Helpers

  user = {
    email: 'test@example.com',
    password: 'testtest'
  }

  restaurant = {
    name: "Itadaki Zen"
  }

  scenario "allows users to leave a review using a form" do
    sign_up(user)
    add_restaurant(restaurant)
    visit '/restaurants'
    click_link "Review Itadaki Zen"
    fill_in "Thoughts", with: "A piece of heaven"
    select '5', from: "Rating"
    click_button "Leave Review"

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('A piece of heaven')
  end

  scenario "does not allow a user to leave multiple reviews" do
    sign_up(user)
    add_restaurant(restaurant)
    visit '/restaurants'
    click_link "Review Itadaki Zen"
    fill_in "Thoughts", with: "A piece of heaven"
    select '5', from: "Rating"
    click_button "Leave Review"
    expect(page).not_to have_content "Leave Review"
  end

end
