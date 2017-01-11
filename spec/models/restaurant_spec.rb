require 'rails_helper'

describe Restaurant, type: :model do

  it 'is not valid with a name of less than 3 characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).errors_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    user = User.create(email: 'test@test.com', password: 'testest', password_confirmation: 'testtest')
    restaurant1 = Restaurant.new(name: "Itadaki Zen")
    restaurant1.user = user
    restaurant1.save
    restaurant = Restaurant.new(name: "Itadaki Zen")
    expect(restaurant).to have(1).error_on(:name)
  end
end
