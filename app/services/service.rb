# Parent class for service objects
class Service
  def self.call(*data, &block)
    new.call(*data, &block)
  end

  def handle_issue(error, *args)
    puts "An error occured: #{error}"
    yield args if block_given?
  end
end