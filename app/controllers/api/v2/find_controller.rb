# frozen_string_literal: true

module V2
  # Api module
  module Api
    # FindController class
    class FindController < ApplicationController
      include RequestHandlers
      include Dry::AutoInject(Container)[
        'models.black_list',
        'services.request_handler'
      ]

      def find
        if black_list.check_token(request.headers['token'])
          @data = request_handler.call(params['search']).value_or([])
          render :find, content_type: 'application/json'
        else
          render json: { message: 'authentication failed' }
        end
      end
    end
  end
end
