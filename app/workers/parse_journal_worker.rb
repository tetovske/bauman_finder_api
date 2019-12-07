class ParseJournalWorker
  include Sidekiq::Worker

  def perform(*args)
    user = User.create :name => 'tet', :password => '1234'
    user.save if user.valid?
  end
end
