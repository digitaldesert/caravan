FROM perl

MAINTAINER Paul Williams <kwakwa@cpan.org>

WORKDIR /opt

# Installing the `psql` client to simplify debugging. Might remove this in the
# future because if someone knows how to change the entrypoint, they'll
# probably know how to add the `psql` client.
RUN apt-get update -qq \
  && apt-get -y --no-install-recommends install postgresql-client

RUN cpanm DBI DBD::Pg Minion Mojo::Pg

COPY . /opt
COPY .pg_service.conf /root/

EXPOSE 3000

ENTRYPOINT ["morbo", "minion.pl"]