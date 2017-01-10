require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: "Youmiko Sushi" }

  scenario "allows users to leave a review using a form" do
    visit '/restaurants'
    click_link "Review Youmiko Sushi"
    fill_in "Thoughts", with: "A piece of heaven"
    select '5', from: "Rating"
    click_button "Leave Review"

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('A piece of heaven')
  end
end
