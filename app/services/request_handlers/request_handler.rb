# frozen_string_literal: true

# Request handler class
module RequestHandlers
  # Request handler class
  class RequestHandler < Service
    include Dry::Monads[:result, :do, :maybe, :try]

    def call(params)
      yield check_params(params)
      options = yield filter_req(params)
      data = yield find(options)

      Success(data)
    end

    private

    def filter_req(params)
      search_params = JSON.parse(params.to_s.gsub('=>', ':'))
      return Success(search_params) unless search_params.empty?

      Failure(:invalid_request)
    end

    def find(params)
      res = Student.where(params).to_a
      return Failure(:students_not_found) if res.nil?

      Success(res)
    end

    def check_params(params)
      return Failure(:invalid_params) if params.nil?

      opt = %w[first_name last_name id_stud]
      res = opt.any? { |par| !params[par].nil? }
      return Failure(:invalid_params) unless res

      Success()
    end
  end
end
