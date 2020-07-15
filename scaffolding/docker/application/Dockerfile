#
# this file is generated via docker-builder/generate.pl
#
# do not edit it directly
#
FROM perl:5.32.0

WORKDIR /var/www
EXPOSE 3000 8080

RUN groupadd --gid 1000 perl \
  && useradd --uid 1000 --gid perl --shell /bin/bash --create-home perl

RUN set -ex \
  && apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    dirmngr \
  && cpanm \
    Cpanel::JSON::XS \
    DBI \
    EV \
    Future::AsyncAwait \
    IO::Socket::Socks \
    Net::SSLeay \
    IO::Socket::SSL \
    Net::DNS::Native \
    Role::Tiny \
    SQL::Abstract \
    Minion \
    DBD::Pg \
    Mojo::Pg \
    DBD::SQLite \
    Mojo::SQLite \
    Email::Send::SMTP \
    Amazon::S3 \
  && rm -r /var/lib/apt/lists/* \
  && rm -r /root/.cpanm

ENV MOJO_VERSION 8.56

RUN cpanm Mojolicious@"$MOJO_VERSION" \
  && rm -r /root/.cpanm

CMD ["morbo", "app/script/app"]