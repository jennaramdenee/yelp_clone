module Helpers

  def sign_up(user)
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: user[:email])
    fill_in('Password', with: user[:password])
    fill_in('Password confirmation', with: user[:password])
    click_button('Sign up')
  end

  def sign_up2(user)
    click_link('Sign up')
    fill_in('Email', with: user2[:email])
    fill_in('Password', with: user2[:password])
    fill_in('Password confirmation', with: user2[:password])
    click_button('Sign up')
  end

  def add_restaurant(restaurant)
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: restaurant[:name]
    click_button 'Create Restaurant'
  end

end
