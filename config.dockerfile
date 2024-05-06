FROM debian:buster-slim
RUN apt-get update && apt-get install -y wget gnupg
RUN wget -qO- https://repos.influxdata.com/influxdb.key | apt-key add -
RUN echo "deb https://repos.influxdata.com/debian buster stable" | tee /etc/apt/sources.list.d/influxdb.list
RUN apt-get update && apt-get install -y telegraf
COPY telegraf.conf /etc/telegraf/telegraf.conf
EXPOSE 8125/udp
CMD ["telegraf"]