FROM alpine:latest

ARG TARGETARCH
ARG OUTLINE_SS_VERSION=1.3.5
ARG PROMETHEUS_VERSION=2.38.0

WORKDIR /tidalab

RUN cd /tidalab

RUN wget https://github.com/satoshin546/ss/releases/download/1.0/tidalab-ss

RUN wget "https://github.com/Jigsaw-Code/outline-ss-server/releases/download/v${OUTLINE_SS_VERSION}/outline-ss-server_${OUTLINE_SS_VERSION}_linux_x86_64.tar.gz"

RUN tar -xzv -C /tidalab -f outline-ss-server_${OUTLINE_SS_VERSION}_linux_x86_64.tar.gz outline-ss-server
    
RUN wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz

RUN tar -zxf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz --strip-components 1 -C /tidalab

RUN chmod +x /tidalab/*

ENTRYPOINT /tidalab/tidalab-ss -api="$API" -token="$TOKEN" -node="$NODE" -license="$LICENSE" -syncInterval="$SYNCINTERVAL"
