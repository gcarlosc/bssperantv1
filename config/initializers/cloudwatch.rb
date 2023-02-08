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




# Aws.config.update({
#   region: ENV.fetch("AWS_REGION"),
#   credentials: Aws::Credentials.new(ENV.fetch("AWS_ACCESS_KEY_ID"), ENV.fetch("AWS_SECRET_ACCESS_KEY"))
# })

# cloudwatch_logs = Aws::CloudWatchLogs::Client.new
# log_stream_name = 'rails-app-logs'
# cloudwatch_logs.create_log_stream(log_group_name: 'bsgiancarlo-logs', log_stream_name: log_stream_name) unless cloudwatch_logs.describe_log_streams(log_group_name: 'bsgiancarlo-logs', log_stream_name_prefix: log_stream_name).log_streams.any?

# class CloudWatchLogger < Logger
#   def initialize
#     super(nil)
#   end

#   def add(severity, message = nil, progname = nil, &block)
#     severity ||= Logger::Severity::UNKNOWN
#     return true if severity < level

#     message = (message || block.call).to_s
#     message = "[#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}] #{message}"

#     cloudwatch_logs.put_log_events(
#       log_group_name: 'bsgiancarlo-logs',
#       log_stream_name: log_stream_name,
#       log_events: [{
#         message: message,
#         timestamp: Time.now.to_i * 1000
#       }]
#     )
#     true
#   end
# end

# config.logger = CloudWatchLogger.new









class CloudwatchLogger < Logger
  def initialize
    @client = Aws::CloudWatchLogs::Client.new
    @log_group_name = 'bsgiancarlo-logs'
    @log_stream_name = 'rails-log'
    @client.create_log_stream(log_group_name: 'bsgiancarlo-logs', log_stream_name: @log_stream_name) unless @client.describe_log_streams(log_group_name: 'bsgiancarlo-logs', log_stream_name_prefix: @log_stream_name).log_streams.any?
  end

  def add(severity, message = nil, progname = nil, &block)
    if message.nil?
      if block_given?
        message = yield
      else
        message = progname
      end
    end

    @client.put_log_events({
      log_group_name: @log_group_name,
      log_stream_name: @log_stream_name,
      log_events: [
        {
          message: message,
          timestamp: Time.now.to_i * 1000
        }
      ]
    })
  end
end

Rails.logger = CloudwatchLogger.new
Rails.logger.level = Logger::DEBUG
