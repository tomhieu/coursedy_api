#!/bin/bash

apt-get install -y nginx

bundle install --without=development,test
bundle exec rake db:migrate

rm /etc/nginx/sites-enabled/*
rm /etc/nginx/sites-available/*
ln -s /coursedy/nginx_conf/nginx.conf /etc/nginx/sites-enabled/coursedy_api.conf

bundle exec rake assets:precompile
bundle exec puma -C config/puma.rb -d

nginx -g daemon off