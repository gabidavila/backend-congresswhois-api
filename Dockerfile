FROM ruby:2.6.1-stretch

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE $PORT

RUN chmod +x init.sh

CMD ["/bin/bash", "init.sh"]
