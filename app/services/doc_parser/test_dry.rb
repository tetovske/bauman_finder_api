require 'dry/transaction'

class DocParser::TestDry
  include Dry::Monads::Result::Mixin
  include Dry::Monads::Do.for(:test)

  def test
    o = yield func1

    Success(10)
  end

  def func1
    Failure('Error')
  end

  def func2
    Success(10)
  end
end