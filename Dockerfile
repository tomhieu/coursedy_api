FROM ruby:2.4.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get install -y nginx
# Configuring main directory
RUN mkdir -p /var/www/coursedy_api
ENV RAILS_ROOT /var/www/coursedy_api
WORKDIR $RAILS_ROOT
# Setting env up
ENV RAILS_ENV='production'
ENV RAKE_ENV='production'
# Adding project files
COPY . $RAILS_ROOT
COPY ./config/docker_app_setting.yml $RAILS_ROOT/config/app_setting.yml
COPY ./config/docker/nginx.conf /etc/nginx/sites-enabled/coursedy_api.conf
RUN rm /etc/nginx/sites-enabled/default
RUN rm /etc/nginx/sites-available/default
RUN bundle install --jobs 20 --retry 5 --without development test
RUN bundle exec rake assets:precompile
RUN bundle exec puma -C config/puma.rb -d

EXPOSE 443
CMD [ "nginx", "-g", "daemon off;" ]