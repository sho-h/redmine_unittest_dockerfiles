FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y libcurl4-openssl-dev libssl-dev curl git-core patch build-essential bison zlib1g-dev libssl-dev libxml2-dev libxml2-dev sqlite3 libsqlite3-dev autotools-dev libxslt1-dev libyaml-0-2 autoconf automake libreadline6-dev libyaml-dev libtool libicu-dev cmake tzdata ruby ruby-dev && \
    apt clean

RUN git clone --depth=1 https://github.com/redmine/redmine.git
ADD database.yml redmine/config/
RUN gem install bundler
RUN cd redmine && \
    bundle install --without rmagick && \
    bundle exec rake db:migrate
