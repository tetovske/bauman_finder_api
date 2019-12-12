# frozen_string_literal: true

# Class for extracting service data from a key_keeper.yaml file
class KeyKeeper < Service
  include Dry::AutoInject(Container)[
    'services.yaml_parser'
  ]

  KEEPER_PATH = "#{Rails.root}/config/key_keeper.yaml"

  def call(resource_key)
    parsed_file = yield parse_keeper_file
    result_data = yield find_by_key(parsed_file, resource_key)

    Success(result_data)
  end

  private

  def parse_keeper_file
    Try { yaml_parser.load_file(KEEPER_PATH) }
      .bind { |file| Success(file) }
      .or(Failure(:file_exception))
  end

  def find_by_key(data, resource_key)
    puts data
    Maybe(data[resource_key]).bind do |value|
      Success(value)
    end.or(Failure(:key_does_not_exists))
  end
end
