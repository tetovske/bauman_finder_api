class TestController < ApplicationController
  include Parsers

  def input
    auth_key = request.headers['token']
    render :json => { header: auth_key }
  end

  def output
    ParserManager.call.update_webvpn_data
  end
end
