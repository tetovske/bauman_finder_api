class TestController < ApplicationController

  def input; end

  def output
    value = params[:n]
    # @response = TestFolder::TestInteractor.call(input: value).res
    @response = DocParser::DecreeParser.call
  end
end