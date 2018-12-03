#!/bin/bash
gem install bundler
bundle install --without=development,test
bundle exec rake db:migrate

sidekiq -c config/sidekiq/default.yml