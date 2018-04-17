require "active_record"

ActiveRecord::Base.establish_connection({
  adapter: 'postgresql',
  #username: 'test',
  #  host: 'localhost'
  database: "game"
  #adapter:  "sqlite3"
})
