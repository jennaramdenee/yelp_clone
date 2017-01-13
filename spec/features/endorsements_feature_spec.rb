require 'rails_helper'

feature 'endorsing reviews' do
  let(:user) { User.create(email: "test@test.com", password: "testingstuff") }
  let(:restaurant) { user.restaurants.create(name: "KFC") }
  let(:review_params) { {rating: 3, thoughts: "It was an abomination"} }

  before do
    restaurant.reviews.create_with_user(review_params, user)
  end

  scenario "a user can endorse a review, which updates the review endorsement count" do
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end

end
