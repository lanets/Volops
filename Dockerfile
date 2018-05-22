FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

#Node.js
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn
    
RUN mkdir /volops
WORKDIR /volops
COPY Gemfile /volops/Gemfile
COPY Gemfile.lock /volops/Gemfile.lock
RUN bundle install
COPY . /volops