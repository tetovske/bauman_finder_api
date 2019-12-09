class ParseJournalWorker
  include Sidekiq::Worker

  def perform(*args)
    # DocParser.call
    puts 'ОООООО!'
    #DocParser::TestDry.call(5)
  end
end
