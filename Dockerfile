FROM ruby:2.6.1-stretch

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE $PORT

RUN curl -o /opt/cloud_sql_proxy https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64
RUN chmod +x /opt/cloud_sql_proxy
RUN /opt/cloud_sql_proxy --instances=$INSTANCE_CONNECTION_NAME=tcp:5432 &

CMD ["rails", "server", "-b", "0.0.0.0"]
