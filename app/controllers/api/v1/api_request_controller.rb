# frozen_string_literal: true

module Api
  module V1
    class ApiRequestController < ApplicationController
      include Dry::Monads[:do, :result]
      include Dry::AutoInject(Container)[
        handler_v1: 'services.request_handler_v1'
      ]

      def handle_request
        @response = handler_v1.call(params).value!
        render :handle_request
      end
    end
  end
end
