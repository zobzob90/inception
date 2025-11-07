FROM debian:bookworm

RUN	apt-get update && apt-get install -y \
	curl \
	bash \
	gnupg \
	ca-certificates \
	&& rm -rf /var/lib/apt/lists/*
RUN	bash -c "$(curl -Ss https://my-netdata.io/kickstart.sh)" --dont-wait --disable-telemetry

EXPOSE	19999

CMD ["/usr/sbin/netdata", "-D"]