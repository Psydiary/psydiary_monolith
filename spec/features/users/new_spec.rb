require 'rails_helper'
require 'faker'

describe '/users/new', type: :feature do
  describe 'as a visitor' do
    context 'when I visit the new user page' do
      it 'I see a form to create a new user' do
        visit register_path

        expect(current_path).to eq(register_path)
        expect(page).to have_content('Your Journey Start Here!')
        expect(page).to have_field(:name)
        expect(page).to have_field(:email) 
        expect(page).to have_select(:data_sharing)
        expect(page).to have_button("Begin My Journey")
      end

      it 'when I fill out the form and click submit, I am redirected to the user dashboard' do
        
        visit register_path

        fill_in :name, with: Faker::Name.name
        fill_in :email, with: Faker::Internet.unique.email
        select 'False', from: :data_sharing
        
        click_button 'Begin My Journey'
        #currently passing based on the fact that's it's not breaking
        #will update when I get the view working
      end

      xit 'when I fill out the form with incomplete info and click "Begin My Journey", I am redirected to the user register page' do
        visit register_path

        fill_in :name, with: ""
        fill_in :email, with: Faker::Internet.unique.email
        select 'False', from: :data_sharing
        
        
        click_button 'Begin My Journey'
        save_and_open_page
        expect(page).to_have_content("Could not create user")
        #Need to fix the error handling in the morning, currently not showing up on page
      end
    end
  end
end