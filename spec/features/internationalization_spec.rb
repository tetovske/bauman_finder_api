require 'rails_helper'

RSpec.feature "Internationalizations", type: :feature do
  describe "if we are going to home page" do
    context "content of header" do
      let(:xpath_to_header) do
        {
          'div[1]/div/p[1]' => 'home_page.after_header.students_in',
          'div[2]/div/p[1]' => 'home_page.after_header.updates'
        }
      end

      it "should contain correct translated header" do
        I18n.available_locales.each do |locale|
          visit "/#{locale}"
          within(:xpath, "/html/body/nav[2]") do
            xpath_to_header.each do |xpath, content|
              expect(page).to have_xpath(xpath, text: I18n.t(content, locale: locale)) 
            end 
          end
        end
      end
    end
    
    context "content of body" do
      let(:xpath_to_body) do
        {
          'div/p[1]' => 'home_page.body.main_txt',
          'div/p[2]' => 'home_page.body.after_main_txt'
        }
      end

      it "should contain correct translated body" do
        I18n.available_locales.each do |locale|
          visit "/#{locale}"
          within(:xpath, "/html/body/div/div/section") do
            xpath_to_body.each do |xpath, content|
              expect(page).to have_xpath(xpath, text: I18n.t(content, locale: locale)) 
            end 
          end
        end
      end
    end
  end
end
