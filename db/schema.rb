require_relative "connection"

ActiveRecord::Schema.define do
  create_table :games , force: :cascade do |t|
    t.string        :sid
    t.string        :name_player, limit: 50
    t.string        :secret_world, limit: 12
    t.string        :answer , limit: 12
    t.string        :incorrect, limit: 50
  end
end
