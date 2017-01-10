require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Itadaki Zen')
    end
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Itadaki Zen')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'promts user to ill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Itadaki Zen'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Itadaki Zen'
      expect(current_path).to eq '/restaurants'\
    end
  end

  context 'viewing restaurants' do
    let!(:mamuska){ Restaurant.create(name:'mamuska')}
    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'mamuska'
      expect(page).to have_content 'mamuska'
      expect(current_path).to eq "/restaurants/#{mamuska.id}"
    end
  end

  context 'editing restaurants' do
    before { Restaurant.create name: "Gdynianka", description: "Homemade pizza, cosy.", id: 1 }
    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link "Edit Gdynianka"
      fill_in "Name", with: "Pizzeria Gdynianka"
      fill_in "Description", with: "Cozy plaze with homemade picca"
      click_button "Update Restaurant"
      click_link "Pizzeria Gdynianka"
      expect(page).to have_content "Pizzeria Gdynianka"
      expect(page).to have_content "Cozy plaze with homemade picca"
      expect(current_path).to eq '/restaurants/1'
    end
  end

  context ' deleting restaurants' do
    before {Restaurant.create name: 'Republika roz', description: 'the best hot chocolate ever'}

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete Republika roz'
      expect(page).not_to have_content 'Republika roz'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

end
