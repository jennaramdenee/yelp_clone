require 'rails_helper'

feature 'restaurants' do
  include Helpers

  user = {
    email: 'test@example.com',
    password: 'testtest'
  }

  user2 = {
    email: 'test2@example.com',
    password: 'test2test2'
  }

  restaurant = {
    name: "Itadaki Zen"
  }

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurants' do
      sign_up(user)
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    scenario 'display restaurants' do
      sign_up(user)
      add_restaurant(restaurant)
      visit '/restaurants'
      expect(page).to have_content('Itadaki Zen')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'promts user to ill out a form, then displays the new restaurant' do
      sign_up(user)
      add_restaurant(restaurant)
      expect(page).to have_content 'Itadaki Zen'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'user cannot add a restaurant if they are not logged in' do
      visit '/restaurants'
      expect(page).not_to have_content "Add a restaurant"
    end

  end



    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        sign_up(user)
          visit '/restaurants'
          click_link 'Add a restaurant'
          fill_in 'Name', with: 'kf'
          click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end

  context 'viewing restaurants' do
    scenario 'lets a user view a restaurant' do
      sign_up(user)
      add_restaurant(restaurant)
      visit '/restaurants'
      click_link 'Itadaki Zen'
      expect(page).to have_content 'Itadaki Zen'
      expect(current_path).to eq "/restaurants/#{Restaurant.first.id}"
    end

    scenario "can view a restaurant even if you have not created it" do
      sign_up(user)
      add_restaurant(restaurant)
      click_link "Sign out"
      sign_up(user2)
      visit '/restaurants'
      click_link 'Itadaki Zen'
      expect(page).to have_content 'Itadaki Zen'
      expect(current_path).to eq "/restaurants/#{Restaurant.first.id}"
    end
  end

  context 'editing restaurants' do
    scenario 'let a user edit a restaurant' do
      sign_up(user)
      add_restaurant(restaurant)
      visit '/restaurants'
      click_link "Edit Itadaki Zen"
      fill_in "Name", with: "Pizzeria Gdynianka"
      fill_in "Description", with: "Cozy plaze with homemade picca"
      click_button "Update Restaurant"
      click_link "Pizzeria Gdynianka"
      expect(page).to have_content "Pizzeria Gdynianka"
      expect(page).to have_content "Cozy plaze with homemade picca"
      expect(current_path).to eq "/restaurants/#{Restaurant.first.id}"
    end

    scenario "can't edit a restaurant if you have not created it" do
      sign_up(user)
      add_restaurant(restaurant)
      click_link "Sign out"
      sign_up(user2)
      visit '/restaurants'
      click_link 'Edit Itadaki Zen'
      expect(page).to have_content "Cannot edit or delete a restaurant you did not create"
    end

  end

  context ' deleting restaurants' do
    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_up(user)
      add_restaurant(restaurant)
      visit '/restaurants'
      click_link 'Delete Itadaki Zen'
      expect(page).not_to have_content 'Itadaki Zen'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario "can't remove a restaurant if you have not created it" do
      sign_up(user)
      add_restaurant(restaurant)
      click_link "Sign out"
      sign_up(user2)
      visit '/restaurants'
      click_link 'Delete Itadaki Zen'
      expect(page).to have_content "Cannot edit or delete a restaurant you did not create"
    end

  end




end
