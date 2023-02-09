# require 'aws-sdk'
# Aws.config.update({
#   region: ENV.fetch("AWS_REGION"), # replace with your desired region
#   credentials: Aws::Credentials.new(ENV.fetch("AWS_ACCESS_KEY_ID"), ENV.fetch("AWS_SECRET_ACCESS_KEY")), # replace with your access key and secret access key
# })

# cloudwatch_logs = Aws::CloudWatchLogs::Client.new

# log_group_name = 'bsgiancarlo-logs'
# log_stream_name = 'rails-app-logs'

# # Create the log group and stream if they don't exist
# cloudwatch_logs.create_log_group(log_group_name: log_group_name) unless cloudwatch_logs.describe_log_groups(log_group_name_prefix: log_group_name).log_groups.any?
# cloudwatch_logs.create_log_stream(log_group_name: log_group_name, log_stream_name: log_stream_name) unless cloudwatch_logs.describe_log_streams(log_group_name: log_group_name, log_stream_name_prefix: log_stream_name).log_streams.any?

# # Get the log stream's upload sequence token
# sequence_token = cloudwatch_logs.describe_log_streams(log_group_name: log_group_name, log_stream_name_prefix: log_stream_name).log_streams.first.upload_sequence_token

# # Write a log event
# cloudwatch_logs.put_log_events(log_group_name: log_group_name, log_stream_name: log_stream_name, log_events: [{ message: 'Hello, CloudWatch Logs!', timestamp: Time.now.utc.to_i * 1000 }], sequence_token: sequence_token)





# require 'aws-sdk-rails'
# require 'aws-sdk-cloudwatchlogs'

# Aws.config.update({
#   region: ENV.fetch("AWS_REGION"),
#   credentials: Aws::Credentials.new(ENV.fetch("AWS_ACCESS_KEY_ID"), ENV.fetch("AWS_SECRET_ACCESS_KEY")),
#   log_level: :debug
# })

# class CloudWatchLogger < Logger
#   def initialize
#     @cloudwatch_logs = Aws::CloudWatchLogs::Client.new
#     @log_stream_name = 'rails-log'
#     @cloudwatch_logs.create_log_stream(log_group_name: 'bsgiancarlo-logs', log_stream_name: @log_stream_name) unless @cloudwatch_logs.describe_log_streams(log_group_name: 'bsgiancarlo-logs', log_stream_name_prefix: @log_stream_name).log_streams.any?
#     super(nil)
#   end

#   def add(severity, message = nil, progname = nil, &block)
#     severity ||= Logger::Severity::UNKNOWN
#     return true if severity < level
#     if message.nil?
#       if block_given?
#         message = yield
#       else
#         message = progname
#       end
#     end
#     message = "[#{severity}] #{message}"
#     puts "XXX = #{severity} #{message} #{progname}"

#     @cloudwatch_logs.put_log_events(
#       log_group_name: 'bsgiancarlo-logs',
#       log_stream_name: @log_stream_name,
#       log_events: [{
#         message: message,
#         timestamp: Time.now.to_i * 1000
#       }]
#     )
#     true
#   end
# end

# Rails.logger = CloudWatchLogger.new
# logger = CloudWatchLogger.new
# logger.level = Logger::DEBUG
# Rails.logger = logger










# Aws.config.update({
#   region: ENV.fetch("AWS_REGION"), # replace with your desired region
#   credentials: Aws::Credentials.new(ENV.fetch("AWS_ACCESS_KEY_ID"), ENV.fetch("AWS_SECRET_ACCESS_KEY")),
#   log_level: :debug
# })

# class CloudwatchLogger < Logger
#   def initialize
#     @client = Aws::CloudWatchLogs::Client.new(
#       region: ENV.fetch("AWS_REGION"),
#       access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
#       secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"),
#       log_level: :debug
#     )
#     @log_group_name = 'bsgiancarlo-logs'
#     @log_stream_name = 'rails-log'
#     @client.create_log_stream(log_group_name: 'bsgiancarlo-logs', log_stream_name: @log_stream_name) unless @client.describe_log_streams(log_group_name: 'bsgiancarlo-logs', log_stream_name_prefix: @log_stream_name).log_streams.any?
#   end

#   # def level=(level)
#   #   @level = level
#   # end

#   def add(severity, message = nil, progname = nil, &block)
#     if message.nil?
#       if block_given?
#         message = yield
#       else
#         message = progname
#       end
#     end

#     # puts "XXX = #{severity} #{message} #{progname}"
#     @client.put_log_events({
#       log_group_name: @log_group_name,
#       log_stream_name: @log_stream_name,
#       log_events: [
#         {
#           message: message,
#           timestamp: Time.now.to_i * 1000
#         }
#       ]
#     })
#   end
# end

# Rails.application.configure do
#   config.log_level = :debug
#   config.logger = CloudwatchLogger.new
# end

# # logger = ActiveSupport::Logger.new(STDOUT)
# # logger.formatter = ->(severity, datetime, progname, msg) { "#{severity} #{msg}\n" }
# logger = CloudwatchLogger.new
# logger.level = Logger::DEBUG
# Rails.logger = logger

# logger = CloudwatchLogger.new
# cloudwatch_logger = Logger.new(Aws::CloudWatchLogs::Client.new(
#       region: ENV.fetch("AWS_REGION"),
#       access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
#       secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"),
#       log_level: :debug
#     ))
# Rails.logger.extend(Logger::Broadcast)
# Rails.logger.broadcast(cloudwatch_logger)










# Aws.config.update({
#   region: ENV.fetch("AWS_REGION"), # replace with your desired region
#   credentials: Aws::Credentials.new(ENV.fetch("AWS_ACCESS_KEY_ID"), ENV.fetch("AWS_SECRET_ACCESS_KEY")), # replace with your access key and secret access key
# })

# cloudwatch_logs = Aws::CloudWatchLogs::Client.new(region: "us-west-2")
# log_group_name = "bsgiancarlo-logs"
# log_stream_name = "production"

# logger = ActiveSupport::Logger.new(STDOUT)
# logger.formatter = ->(severity, datetime, progname, msg) { "#{severity} #{msg}\n" }
# logger.extend(ActiveSupport::Logger.broadcast(CloudwatchLogger.new))
# Rails.logger = logger











# require 'aws-sdk-cloudwatchlogs'

# class CloudWatchLogger < ActiveSupport::Logger
#   def initialize(log_group_name, log_stream_name)
#     @log_group_name = log_group_name
#     @log_stream_name = log_stream_name
#     # super(Rails.root.join("log/#{Rails.env}.log"))
#   end

#   def add(severity, message = nil, progname = nil, &block)
#     # Only log messages with severity of "debug" or higher
#     return unless severity >= Logger::DEBUG

#     # Initialize the AWS SDK
#     Aws.config.update({
#       region: ENV.fetch("AWS_REGION"),
#       credentials: Aws::Credentials.new(ENV.fetch("AWS_ACCESS_KEY_ID"), ENV.fetch("AWS_SECRET_ACCESS_KEY")),
#       log_level: :debug
#     })

#     cloudwatch_logs = Aws::CloudWatchLogs::Client.new

#     # Create the log group and stream if they don't exist
#     cloudwatch_logs.create_log_group(log_group_name: @log_group_name) unless cloudwatch_logs.describe_log_groups(log_group_name_prefix: @log_group_name).log_groups.any?
#     cloudwatch_logs.create_log_stream(log_group_name: @log_group_name, log_stream_name: @log_stream_name) unless cloudwatch_logs.describe_log_streams(log_group_name: @log_group_name, log_stream_name_prefix: @log_stream_name).log_streams.any?

#     # Get the log stream's upload sequence token
#     sequence_token = cloudwatch_logs.describe_log_streams(log_group_name: @log_group_name, log_stream_name_prefix: @log_stream_name).log_streams.first.upload_sequence_token

#     # Write a log event
#     # message = message || block.call
#     puts "XXXXXXXXXXXXXX"
#     cloudwatch_logs.put_log_events(log_group_name: @log_group_name, log_stream_name: @log_stream_name, log_events: [{ message: message, timestamp: Time.now.utc.to_i * 1000 }], sequence_token: sequence_token)

#     super(severity, message, progname, &block)
#   end
# end

# logger = CloudWatchLogger.new('bsgiancarlo-logs', 'rails-log')
# logger.level = Logger::DEBUG
# Rails.logger = logger

# Rails.application.configure do
#   puts "VVVCCC"
#   config.logger = CloudWatchLogger.new('bsgiancarlo-logs', 'rails-log')
# end








# client = Aws::CloudWatchLogs::Client.new(
#   region: ENV.fetch("AWS_REGION"),
#   access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
#   secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY")
# )

# logger = Logger.new(client)
# logger.level = Logger::DEBUG

# config.logger = logger







# Rails.application.config.logger = Logger.new(CloudWatchLogger.new(
#   log_group_name: 'bsgiancarlo-logs',
#   log_stream_name: 'rails-log',
#   access_key_id: ENV['AWS_ACCESS_KEY_ID'],
#   secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
#   region: 'us-east-2'
# ))









cw = Aws::CloudWatchLogs::Client.new(
      region: ENV.fetch("AWS_REGION"),
      access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
      secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY")
    )

log_group_name = 'bsgiancarlo-logs'
log_stream_name = Rails.env

begin
  cw.create_log_group(log_group_name: log_group_name)
rescue Aws::CloudWatchLogs::Errors::ResourceAlreadyExistsException
end

begin
  cw.create_log_stream(log_group_name: log_group_name, log_stream_name: log_stream_name)
rescue Aws::CloudWatchLogs::Errors::ResourceAlreadyExistsException
end

Rails.logger.extend(
  ActiveSupport::Logger.broadcast(
    Logger.new(StringIO.new).tap do |logger|

      logger.formatter = Rails.logger.formatter
      logger.level = Rails.logger.level

      logger.extend(Module.new do
        def add(severity, message = nil, progname = nil, &block)
          super
          return unless severity >= Rails.logger.level

          cw = Aws::CloudWatchLogs::Client.new(
            region: ENV.fetch("AWS_REGION"),
            access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
            secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY")
          )
          log_group_name = 'bsgiancarlo-logs'
          log_stream_name = Rails.env


          message = (message || (block && block.call) || progname).to_s
          cw.put_log_events(
            log_group_name: log_group_name,
            log_stream_name: log_stream_name,
            log_events: [{
              message: message,
              timestamp: Time.now.utc.to_i * 1000
            }]
          )
        end
      end)
    end
  )
)
