require 'dry/transaction'

class DocParser::TestDry < Service
  include Dry::Transaction
  include Dry::Monads::Result::Mixin

  step :prepare
  step :solve

  private

  def prepare(input)
    Success(50)
  end

  def solve(input)
    Success[50, 70, 30]
  end
end