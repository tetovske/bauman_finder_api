require 'rails_helper'

RSpec.feature "Logins", type: :feature do  
  let(:fake_user) { FactoryBot.build(:default_user) }  
  let(:not_hacker) { FactoryBot.create(:default_user) }
  let(:admin) { FactoryBot.create(:admin) }

  describe "user authentication thru devise" do
    scenario "hacker trying to login" do
      locale = I18n.default_locale
      visit "/#{locale}#{new_user_session_path}"
      within(:xpath, '//*[@id="new_user"]') do
        fill_in "user[email]",	with: fake_user.email
        fill_in "user[password]",	with: fake_user.password
      end
      click_button "commit"
      expect(page).to have_content(I18n.t('devise.failure.not_found_in_database', locale: locale)) 
    end
  
    scenario "default user trying to login" do
      locale = I18n.default_locale
      visit "/#{locale}#{new_user_session_path}"
      within(:xpath, '//*[@id="new_user"]') do
        fill_in "user[email]",	with: not_hacker.email
        fill_in "user[password]",	with: not_hacker.password
      end
      click_button "commit"
      expect(page).to have_content(I18n.t('devise.sessions.signed_in', locale: locale)) 
    end

    scenario "admin trying to login" do
      locale = I18n.default_locale
      visit "/#{locale}#{new_user_session_path}"
      within(:xpath, '//*[@id="new_user"]') do
        fill_in "user[email]",	with: admin.email
        fill_in "user[password]",	with: admin.password
      end
      click_button "commit"
      expect(page).to have_content(I18n.t('home_page.admin', locale: locale)) 
    end
  end
end
