# Parent class for service objects
class Service
  include Dry::Monads::Maybe::Mixin
  include Dry::Monads::Result::Mixin
  include Dry::Monads::Try::Mixin
  include Dry::Transaction

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