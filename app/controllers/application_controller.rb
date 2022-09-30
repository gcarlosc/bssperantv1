class ApplicationController < ActionController::Base
  before_action :set_schema

  def set_schema
    ActiveRecord::Base.connection.schema_search_path = "#{ENV.fetch("SCHEMA", 'public')},hstore"
  end
end
