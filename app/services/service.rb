# frozen_string_literal: true

# Parent class for service objects
class Service
  include Dry::Monads[:maybe, :result, :do, :try]

  def handle_issue(error, return_value)
    puts "An error occured: #{error}"
    return_value
  end

  class << self
    def call(*data, &block)
      new.call(*data, &block)
    end
  end
end