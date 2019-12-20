class ParseJournalWorker
  include Sidekiq::Worker

  def perform(*args)
    Parsers::ParserManager.call.update_webvpn_data
  end
end
