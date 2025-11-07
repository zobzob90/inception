FROM	alpine:3.19

RUN		apk update && apk add --nocache vsftpd openssl

COPY	conf/vsftpd.conf /ect/vsftpd/vsftpd.conf
COPY	tools/setup.sh /usr/local/bin/setup.sh

RUN		chmod +x /usr/local/bin/setup.sh

CMD ["/usr/local/bin/setup.sh"]