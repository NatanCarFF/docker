FROM debian:latest
RUN apt-get update && apt-get install -y \
    telegraf \
    mtr
RUN echo "[agent]" > /etc/telegraf/telegraf.conf && \
    echo "  interval = '10s'" >> /etc/telegraf/telegraf.conf && \
    echo "  round_interval = true" >> /etc/telegraf/telegraf.conf && \
    echo "  metric_batch_size = 1000" >> /etc/telegraf/telegraf.conf && \
    echo "  metric_buffer_limit = 10000" >> /etc/telegraf/telegraf.conf && \
    echo "  collection_jitter = '0s'" >> /etc/telegraf/telegraf.conf && \
    echo "  flush_interval = '10s'" >> /etc/telegraf/telegraf.conf && \
    echo "  flush_jitter = '0s'" >> /etc/telegraf/telegraf.conf && \
    echo "  precision = ''" >> /etc/telegraf/telegraf.conf && \
    echo "  debug = false" >> /etc/telegraf/telegraf.conf && \
    echo "  quiet = false" >> /etc/telegraf/telegraf.conf && \
    echo "  logfile = '/var/log/telegraf/telegraf.log'" >> /etc/telegraf/telegraf.conf && \
    echo "  hostname = ''" >> /etc/telegraf/telegraf.conf && \
    echo "  omit_hostname = false" >> /etc/telegraf/telegraf.conf && \
    echo "  [[outputs.influxdb]]" >> /etc/telegraf/telegraf.conf && \
    echo "    urls = ['http://influxdb:8086']" >> /etc/telegraf/telegraf.conf && \
    echo "    database = 'telegraf'" >> /etc/telegraf/telegraf.conf
EXPOSE 80
docker build -t meu_telegraf_mtr_image .
docker run -d -p 80:80 --name meu_contêiner_telegraf_mtr meu_telegraf_mtr_image
