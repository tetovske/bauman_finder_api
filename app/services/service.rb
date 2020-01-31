# frozen_string_literal: true

# Parent class for service objects
class Service
  include Dry::Monads[:maybe, :result, :do, :try]

  class << self
    def call(*data, &block)
      new.call(*data, &block)
    end
  end
end
