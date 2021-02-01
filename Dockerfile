FROM alpine
ARG TARGETOS
ARG TARGETARCH
ENV TARGETOS=${TARGETOS:-linux}
ENV TARGETARCH=${TARGETARCH:-amd64}

ARG HELM_LATEST_VERSION="v3.5.0"

RUN apk add --update ca-certificates \
 && apk add --update -t deps wget git openssl bash \
 && wget -q https://get.helm.sh/helm-${HELM_LATEST_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz \
 && tar -xf helm-${HELM_LATEST_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz \
 && mv ${TARGETOS}-${TARGETARCH}/helm /usr/local/bin \
 && apk del --purge deps \
 && rm /var/cache/apk/* \
 && rm -f /helm-${HELM_LATEST_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz

ENTRYPOINT ["helm"]
CMD ["help"]
