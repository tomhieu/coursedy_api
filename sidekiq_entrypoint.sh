#!/bin/bash

bundle install --without=development,test
bundle exec rake db:migrate

sidekiq -c config/sidekiq/default.yml