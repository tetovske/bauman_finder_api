# frozen_string_literal: true

# Request handler class
module RequestHandlers
  class RequestHandler < Service
    include Dry::Monads[:result, :do]

    def call(params)
      options = yield filter_req(params)
      data = find(options)

      Success(data)
    end

    private

    def filter_req(params)
      data = {
        first_name: params[:name],
        last_name: params[:last_name],
        mid_name: params[:mid_name],
        stud_id: params[:id]
      }
      data = data.reject { |k, v| v.nil? }
      return Success(data) unless data.empty?

      Failure(:invalid_request)
    end

    def find(params)
      res = Student.where(params)
      res.map do |rec|
        rec.subject_data = JSON.parse(rec.subject_data.to_json) unless rec.subject_data.nil?
        rec
      end
    end
  end
end
