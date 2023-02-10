namespace :scheduler do
  desc "generate post"
  task auto_post_generate: :environment do
    ActiveRecord::Base.connection.schema_search_path = "#{ENV.fetch("SCHEMA", 'public')},hstore"
    Post.create(name: "task-#{Time.current.to_s}")
  end
end
