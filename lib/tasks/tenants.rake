namespace :tenants do
  namespace :db do
    desc "runs db:migrate on each tenant's private schema"
    task migrate: :environment do
      version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
      migration_scope_block = -> (migration) { ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope) }
      # ActiveRecord::Migration.verbose = verbose
      Account.order(:id).each do |account|
        puts "migration tenant #{account.id} (#{account.name})"
        ActiveRecord::Base.connection.schema_search_path = account.schema
        ActiveRecord::Base.connection.migration_context.migrate(version, &migration_scope_block)
      end
    end

    desc "runs db:rollback on each tenant's private schema"
    task rollback: :environment do
      step = ENV["STEP"] ? ENV["STEP"].to_i : 1
      Account.order(:id).each do |account|
        puts "Schema rolled back tenant #{account.id} (#{account.name})"
        ActiveRecord::Base.connection.schema_search_path = account.schema
        ActiveRecord::Base.connection.migration_context.rollback(step)
      end
    end

    desc 'new functions groupdate'
    task groupdate: :environment do
      accounts do
        directory = File.expand_path 'vendor'
        path = File.join directory, 'postgresql.sql'
        ActiveRecord::Base.connection.execute( File.read(path))
      end
    end

    desc "down tenant by VERSION"
    task down: :environment do
      version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
      raise "VERSION is required" if version.nil?
      accounts do
        ActiveRecord::Base.connection.migration_context.run(:down, version)
      end
    end
  end

  def accounts
    Account.all.each do |account|
      puts "select #{account.id} (#{account.name})"
      ActiveRecord::Base.connection.schema_search_path = account.schema
      yield
    end
  end
end
