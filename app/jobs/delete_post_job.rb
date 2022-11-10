class DeletePostJob < Struct.new(:schema, :post_id)
  def perform
    puts "========= DELETE POST #{schema} post_id: #{post_id}========="
    post = Post.find_by(id: post_id)
    post.destroy if post
  end

  def before(job)
    ActiveRecord::Base.connection.schema_search_path = schema
    sleep 5
  end

  def after(job)
    ActiveRecord::Base.connection.schema_search_path = 'public, hstore'
  end

  def max_attempts
    return 1
  end
end
