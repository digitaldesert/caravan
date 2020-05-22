FROM perl:5.30.2

WORKDIR /usr/src/application
EXPOSE 3000

RUN groupadd --gid 1000 perl \
  && useradd --uid 1000 --gid perl --shell /bin/bash --create-home perl

RUN set -ex \
  && apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    dirmngr \
  && rm -r /var/lib/apt/lists/*

COPY cpanfile .
RUN cpanm --installdeps .\
    && rm -r /root/.cpanm

#CMD ["hypnotoad", "-f", "script/application"]
CMD ["morbo", "-f", "script/application"]
