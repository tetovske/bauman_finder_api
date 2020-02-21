require 'rails_helper'

RSpec.feature "ApiSearches", type: :feature do

  describe "v1 api" do
    let(:create_user) { FactoryBot.create(:default_user) }

    context "if we are submit options without APIKEY" do
      let(:result_without_key) do
        {
          'status': 'failed',
          'cause': 'missing_token',
          'data': []
        }
      end  

      it "should return empty list because there is no APIKEY" do
        visit v1_handler_path(search_meth: 'find')
        expect(JSON.parse(page.body).transform_keys(&:to_sym)).to eq(result_without_key)
      end
    end

    context "if we are submitting options with APIKEY" do
      context "if we submitting invalid arguments with valid APIKEY" do
        let(:missing_search_args) do
          {
            'status': 'failed',
            'cause': 'missing_search_args',
            'data': []
          }
        end  
        let(:nvalid_search_meth) do
          {
            'status': 'failed',
            'cause': 'invalid_search_method',
            'data': []
          }
        end  

        it "should return cause = missing_search_args" do
          visit v1_handler_path(search_meth: 'find', APIKEY: create_user.bf_api_token)
          expect(JSON.parse(page.body).transform_keys(&:to_sym)).to eq(missing_search_args)
        end

        it "should return cause = invalid_search_method beacause we have invalid_search_meth!" do
          visit v1_handler_path(search_meth: 'finds', APIKEY: create_user.bf_api_token)
          expect(JSON.parse(page.body).transform_keys(&:to_sym)).to eq(nvalid_search_meth)
        end
      end

      context "if we are submitting valid args" do

        it "should have status 'success'" do
          visit v1_handler_path(search_meth: 'find', APIKEY: create_user.bf_api_token, name: 'Name')
          expect(JSON.parse(page.body)['status']).to eq('success')
        end

        it "should return student" do
          student = FactoryBot.create(:student)
          visit v1_handler_path(search_meth: 'find', APIKEY: create_user.bf_api_token, name: student.first_name)
          expect(JSON.parse(page.body)['status']).to eq('success')
        end
      end

      context "and want to print all students" do
        create_student

        it "should return not empty list" do
          visit v1_handler_path(search_meth: 'find_except', APIKEY: create_user.bf_api_token, name: '')
          expect(JSON.parse(page.body)['status']).to eq('success')
          expect(JSON.parse(page.body)['data']).not_to be_empty
        end
      end
    end
  end
end
