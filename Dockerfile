FROM python:3.10-alpine

# create a non-privileged user to use at runtime
RUN addgroup -g 50 -S pgadmin \
 && adduser -D -S -h /pgadmin -s /sbin/nologin -u 1000 -G pgadmin pgadmin \
 && mkdir -p /pgadmin/config /pgadmin/storage /var/log/pgadmin /var/lib/pgadmin \
 && chown -R 1000:50 /pgadmin \
 && chown -R 1000:50 /var/log/pgadmin \
 && chown -R 1000:50 /var/lib/pgadmin

# Install postgresql tools for backup/restore
RUN apk add --no-cache libedit postgresql \
 && cp /usr/bin/psql /usr/bin/pg_dump /usr/bin/pg_dumpall /usr/bin/pg_restore /usr/local/bin/ \
 && apk del postgresql

RUN apk add --no-cache postgresql-dev libffi-dev zlib-dev jpeg-dev

ENV PGADMIN_VERSION=6.3
ENV PYTHONDONTWRITEBYTECODE=1
ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1

RUN apk add --no-cache alpine-sdk linux-headers \
 && pip install --upgrade pip \
 && echo "https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v${PGADMIN_VERSION}/pip/pgadmin4-${PGADMIN_VERSION}-py3-none-any.whl" | pip install --no-cache-dir -r /dev/stdin \
 && pip install --no-cache-dir --upgrade Flask-WTF==0.14.3 \
 && pip install simple-websocket \
 && apk del alpine-sdk linux-headers

EXPOSE 5050

COPY config_distro.py /usr/local/lib/python3.10/site-packages/pgadmin4/

USER pgadmin:pgadmin
CMD ["python", "./usr/local/lib/python3.10/site-packages/pgadmin4/pgAdmin4.py"]
VOLUME /pgadmin/
