FROM debian:latest
RUN apt-get update \
    && apt-get install -y wget gnupg \
    && rm -rf /var/lib/apt/lists/*
RUN wget -qO- https://repos.influxdata.com/influxdb.key | apt-key add -
RUN wget -q https://repos.influxdata.com/influxdata-archive_compat.key \
    && echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c \
    && cat influxdata-archive_compat.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null \
    && rm influxdata-archive_compat.key
RUN echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | tee /etc/apt/sources.list.d/influxdata.list
RUN apt-get update
RUN apt-get install -y telegraf mtr
RUN rm -rf /var/lib/apt/lists/*
COPY telegraf.conf /etc/telegraf/telegraf.conf
CMD ["telegraf", "--config", "/etc/telegraf/telegraf.conf"]

