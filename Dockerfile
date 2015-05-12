FROM jkrage/oraclejava
MAINTAINER Joshua Krage <jkrage@guisarme.us>

RUN echo "deb http://packages.elastic.co/elasticsearch/1.5/debian stable main" | tee /etc/apt/sources.list.d/elasticsearch.list \
    && apt-key adv --keyserver hkp://pgp.mit.edu --recv-keys D88E42B4 \
    && apt-get update \
    && apt-get -y install elasticsearch \
    && update-rc.d elasticsearch defaults 95 10 \
    && mkdir /usr/share/elasticsearch/data \
    && chown elasticsearch:elasticsearch /usr/share/elasticsearch/data \
    && chown elasticsearch:elasticsearch /etc/elasticsearch/* \
    && rm -rf /var/lib/apt/lists/*

ENV PATH /usr/share/elasticsearch/bin:$PATH

VOLUME /usr/share/elasticsearch/data
VOLUME /etc/elasticsearch

EXPOSE 9200 9300

USER elasticsearch

CMD ["/usr/share/elasticsearch/bin/elasticsearch"]
