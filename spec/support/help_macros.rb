module HelpMacros
  def login_user
    before(:each) do
      locale = I18n.default_locale
      fake_user = FactoryBot.create(:default_user)
      visit "#{locale}#{new_user_session_path}"
      within(:xpath, '//*[@id="new_user"]') do
        fill_in "user[email]",	with: fake_user.email
        fill_in "user[password]",	with: fake_user.password
      end
      click_button "commit"
    end
  end

  def instantiate_user
    before(:each) do
      FactoryBot.create(:default_user)
    end
  end

  def create_student
    before(:each) do
      FactoryBot.create(:student)
    end
  end
end