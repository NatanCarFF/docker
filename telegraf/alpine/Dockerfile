FROM alpine:latest
RUN apk add --no-cache telegraf mtr
COPY telegraf.conf /etc/telegraf/telegraf.conf
EXPOSE 8125/udp
CMD ["telegraf", "--config", "/etc/telegraf/telegraf.conf"]

