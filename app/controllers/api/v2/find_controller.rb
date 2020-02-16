# frozen_string_literal: true

module Api
  # Api module
  module V2
    # FindController class
    class FindController < ApplicationController
      include RequestHandlers
      include Dry::AutoInject(Container)[
        'models.black_list',
        'services.request_handler_v2'
      ]

      def find
        if black_list.check_token(request.headers['token'])
          @response = request_handler_v2.call(params['search']).value!
          render :find, content_type: 'application/json'
        else
          render json: { message: 'authentication failed' }
        end
      end
    end
  end
end
