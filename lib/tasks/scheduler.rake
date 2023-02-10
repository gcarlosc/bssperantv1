namespace :scheduler do
  desc "generate post"
  task post_1min: :environment do
    ActiveRecord::Base.connection.schema_search_path = "#{ENV.fetch("SCHEMA", 'public')},hstore"
    Post.create(name: "1min-#{Time.current.to_s}")
  end

  task post_5min: :environment do
    ActiveRecord::Base.connection.schema_search_path = "#{ENV.fetch("SCHEMA", 'public')},hstore"
    Post.create(name: "5min-#{Time.current.to_s}")
  end

  task :post_one_schema, [:account] => [:environment] do |t, args|
    account = Account.find_by_name(args[:account])
    ActiveRecord::Base.connection.schema_search_path = account.schema
    Post.create(name: "#{args[:account]}-#{Time.current.to_s}")
  end
end
