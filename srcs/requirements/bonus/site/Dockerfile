FROM alpine:3.19

RUN apk update && apk upgrade && \
	apk add --no-cache nginx && \
	mkdir -p /var/www/html && \
	mkdir -p /run/nginx

COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

COPY ./html /var/www/html/
COPY ./css /var/www/html/css/
COPY ./galery_photo /var/www/html/galery_photo/

COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 80

CMD ["/usr/local/bin/setup.sh"]
