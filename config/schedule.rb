every 1.minutes do
  rake "scheduler:post_1min"
end

every 5.minutes do
  rake "scheduler:post_5min"
end

every 5.minutes do
  rake "scheduler:post_one_schema['test']"
end
