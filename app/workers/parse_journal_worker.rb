class ParseJournalWorker
  include Sidekiq::Worker

  def perform(arg)
    Parsers::ParserManager.call.update_webvpn_data
  end
end
