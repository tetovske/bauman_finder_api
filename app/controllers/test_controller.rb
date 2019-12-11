class TestController < ApplicationController

  def input; end

  def output
    value = params[:n]
    # @response = TestFolder::TestInteractor.call(input: value).res
    @response = KeyKeeper.call('doc_parser_config').value!
  end
end
