FROM	alpine:3.19

RUN		apk add --no-cache ca-certificates wget libc6-compat device-mapper

RUN 	wget https://github.com/google/cadvisor/releases/download/v0.47.2/cadvisor-v0.47.2-linux-amd64 \
		-O /usr/bin/cadvisor && \
		chmod +x /usr/bin/cadvisor

EXPOSE	8080

CMD	["/usr/bin/cadvisor", "-logtostderr"]