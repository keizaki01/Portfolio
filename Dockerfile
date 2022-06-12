FROM ruby:2.7.5
RUN apt-get update && \
    apt-get install -y mariadb-client nodejs vim --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /myproject

ADD Gemfile /myproject/Gemfile
ADD Gemfile.lock /myproject/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /myproject

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

RUN apt-get update -qq && apt-get install -y nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs
