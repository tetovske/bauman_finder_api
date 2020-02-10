class Api::V1::ApiRequestController < ApplicationController
  def handle_request
    @res = params[:search_meth]
    render :handle_request
  end
end
