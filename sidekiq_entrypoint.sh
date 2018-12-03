#!/bin/bash
gem install bundler
bundle install --without=development,test
bundle exec rake db:migrate

sidekiq -C config/sidekiq/default.yml