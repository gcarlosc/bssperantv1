class CreatePostJob
  include Sidekiq::Worker
  sidekiq_options queue: 'cloud66', retry: 1

  def perform
    ActiveRecord::Base.connection.schema_search_path = 'r148581227346de8c711aced4008225, hstore'
    post = Post.create(name: "#{Time.current.to_i}-uuid")
    puts "======== created post ========"
    puts post.inspect
    puts "=============================="
    ActiveRecord::Base.connection.schema_search_path = 'public, hstore'
  end
end
