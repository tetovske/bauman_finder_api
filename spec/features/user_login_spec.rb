require 'rails_helper'

RSpec.describe 'login/logout specs' do
  describe 'home page content' do
    it 'should check presense of main inscription' do
      visit '/ru'
      expect(page).to have_content('Найдутся все!')
    end
  end
end