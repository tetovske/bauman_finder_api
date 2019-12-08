class ParseJournalWorker
  include Sidekiq::Worker

  def perform(*args)
    DocParser.call
  end
end
