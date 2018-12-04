FROM ruby:2.4.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
#RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
#RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
#RUN sudo apt-get update && sudo apt-get install --no-install-recommends yarn

# Configuring main directory
RUN mkdir -p /var/www/coursedy_api
ENV RAILS_ROOT /var/www/coursedy_api
WORKDIR $RAILS_ROOT
# Setting env up
ENV RAILS_ENV='production'
ENV RAKE_ENV='production'
# Adding project files
COPY . $RAILS_ROOT
COPY ./config/docker_app_setting.yml $RAILS_ROOT/config/app_settings.yml
RUN ["chmod", "+x", "./web_entrypoint.sh"]
RUN ["chmod", "+x", "./sidekiq_entrypoint.sh"]

EXPOSE 443