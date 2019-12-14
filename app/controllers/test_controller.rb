class TestController < ApplicationController
  include Parsers

  def input; end

  def output
    value = params[:n]
    # @response = TestFolder::TestInteractor.call(input: value).res
    @response = ParserManager.call.update_decree_data
  end
end
