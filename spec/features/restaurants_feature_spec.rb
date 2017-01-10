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


end
