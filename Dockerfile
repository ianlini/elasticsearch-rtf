FROM java:8-jre
MAINTAINER Ian <ian.lin@yoctol.com>

# es needs non-root user to start

RUN cd /tmp && curl -OL https://github.com/ianlini/elasticsearch-rtf/archive/master.zip && \
  unzip master.zip -d /usr/share && rm /tmp/master.zip && \
  mv /usr/share/elasticsearch-rtf-master /usr/share/elasticsearch && \
  groupadd es && useradd -g es es && \
  for path in data config logs config/scripts; do mkdir -p "/usr/share/elasticsearch/$path"; done && \
  chown -R es:es /usr/share/elasticsearch

ENV PATH /usr/share/elasticsearch/bin:$PATH
ENV ES_HEAP_SIZE 10g

VOLUME /usr/share/elasticsearch/config

VOLUME /usr/share/elasticsearch/data

VOLUME /usr/share/elasticsearch/logs

USER es

EXPOSE 9200 9300

CMD ["elasticsearch"]