FROM dotledger_dotledger:latest

USER root
RUN chown -R root:root /app/

RUN apk --update add fontconfig curl curl-dev

ENV PHANTOMJS_ARCHIVE="phantomjs.tar.gz"

RUN curl -Lk -o $PHANTOMJS_ARCHIVE https://github.com/fgrehm/docker-phantomjs2/releases/download/v2.0.0-20150722/dockerized-phantomjs.tar.gz \
   && tar -xf $PHANTOMJS_ARCHIVE -C /tmp/ \
   && cp -R /tmp/etc/fonts /etc/ \
   && cp -R /tmp/lib/* /lib/ \
   && cp -R /tmp/lib64 / \
   && cp -R /tmp/usr/lib/* /usr/lib/ \
   && cp -R /tmp/usr/lib/x86_64-linux-gnu /usr/ \
   && cp -R /tmp/usr/share/* /usr/share/ \
   && cp /tmp/usr/local/bin/phantomjs /usr/bin/ \
   && rm -fr $PHANTOMJS_ARCHIVE /tmp/*

RUN bundle install --with deveopment test

COPY docker-entrypoint.spec.sh /app/docker-entrypoint.sh
COPY spec /app/spec
COPY .rspec /app/.rspec
COPY .rubocop.yml /app/.rubocop.yml
COPY Rakefile /app/Rakefile

RUN echo "--force-color" >> /app/.rspec
