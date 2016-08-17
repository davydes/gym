# Use single connection, because SQLite not support concurrency connections
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection ||= retrieve_connection

  def self.connection
    @@shared_connection
  end
end