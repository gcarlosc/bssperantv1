web: bundle exec puma -C /opt/elasticbeanstalk/config/private/pumaconf.rb
worker: bundle exec rake jobs:work
sidekiq: bundle exec sidekiq -e production -C config/sidekiq.yml
