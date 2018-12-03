#!/bin/bash
apt-get install -y nginx

gem install bundler
bundle install --without=development,test
bundle exec rake db:migrate

rm /etc/nginx/sites-enabled/*
rm /etc/nginx/sites-available/*
ln -s /coursedy/nginx_conf/nginx.conf /etc/nginx/sites-enabled/coursedy_api.conf

bundle exec rake assets:precompile
bundle exec puma -C config/puma.rb -d

echo "daemon off;" >> /etc/nginx/nginx.conf
nginx