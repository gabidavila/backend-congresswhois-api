FROM ruby:2.6.1-stretch

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE $PORT

CMD ["rails", "server", "-b", "0.0.0.0"]
