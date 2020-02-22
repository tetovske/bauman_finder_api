class ParseJournalWorker
  include Sidekiq::Worker

  def perform
    puts "PARSER STARTED:"
    Parsers::ParserManager.call.update_webvpn_data
  end
end
