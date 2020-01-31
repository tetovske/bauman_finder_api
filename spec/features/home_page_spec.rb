require 'rails_helper'

RSpec.describe 'home page' do
  describe 'home page content' do
    it 'should check presense of main inscription' do
      visit '/ru'
      expect(page).to have_content('Найдутся все!')
    end

    it 'should check presence of header elements' do
      visit '/ru'
      elems = %w[.container .navbar .header .is-spaced .navbar-brand]
      elems.each { |elem| expect(page).to have_css(elem) }
    end
  end

  describe 'some internationalization tests' do
    it 'should be translated into English' do
      visit '/en'
      sel1 = '.main-page-title'
      sel2 = 'div.level-item:nth-child(2) > div:nth-child(1) > p:nth-child(1)'
      expect(page.find(sel1)).to have_content 'There are all!'
      expect(page.find(sel2)).to have_content 'Data is updated every'
    end

    it 'should be translated into Russian' do
      visit '/ru'
      sel1 = '.main-page-title'
      sel2 = 'div.level-item:nth-child(2) > div:nth-child(1) > p:nth-child(1)'
      expect(page.find(sel1)).to have_content 'Найдутся все!'
      expect(page.find(sel2)).to have_content 'Данные обновляются каждые'
    end
  end
end