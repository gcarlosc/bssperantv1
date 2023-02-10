namespace :scheduler do
  desc "generate post"
  task auto_post_generate: :environment do
    ActiveRecord::Base.connection.schema_search_path = "#{ENV.fetch("SCHEMA", 'public')},hstore"
    Post.create(name: "1min-#{Time.current.to_s}")
  end

  task auto_post_generate: :environment do
    ActiveRecord::Base.connection.schema_search_path = "#{ENV.fetch("SCHEMA", 'public')},hstore"
    Post.create(name: "5min-#{Time.current.to_s}")
  end
end
