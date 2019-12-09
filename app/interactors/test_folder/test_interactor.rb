class TestFolder::TestInteractor
  include Interactor

  def call
    context.res = context.input.to_i * 5
    puts 'Hello Im interactor!'
  end
end