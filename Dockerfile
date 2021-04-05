FROM ruby:2.7.2-alpine3.13

ENV RAILS_HOME=/app

RUN mkdir -p $RAILS_HOME

WORKDIR $RAILS_HOME

COPY . $RAILS_HOME

RUN apk add --update \
      build-base \
      sqlite-dev \
      nodejs \
      tzdata \
      yarn

RUN rm -rf /var/cache/apk/*

RUN gem install bundler -v 2.2.9

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle check || bundle install

RUN yarn install --check-files

EXPOSE 3000

ENTRYPOINT ["./docker-entrypoint.sh"]