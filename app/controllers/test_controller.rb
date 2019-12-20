class TestController < ApplicationController
  include Parsers

  def input
    
  end

  def output
    @response = ParserManager.call.update_webvpn_data
  end
end
