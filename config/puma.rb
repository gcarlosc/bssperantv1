max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

port ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "development" }
pidfile ENV.fetch("PIDFILE") { "/tmp/web_server.pid" }

workers ENV.fetch("WEB_CONCURRENCY") { 2 }
preload_app!

directory ENV.fetch("STACK_PATH") { "." }
bind ENV.fetch("BIND") { "unix:///tmp/web_server.sock" }
