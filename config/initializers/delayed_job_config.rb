Delayed::Worker.sleep_delay = 60
Delayed::Worker.max_attempts = 1
Delayed::Worker.max_run_time = 10.minutes
Delayed::Worker.default_queue_name = 'default'
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))
