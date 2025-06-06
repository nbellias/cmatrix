#Build Container Image
FROM alpine as cmatrixbuilder

LABEL org.opencontainers.image.authors="Nikolaos Bellias" \
  org.opencontainers.image.description="Container image for https://github.com/nbellias/cmatrix"

WORKDIR cmatrix

RUN apk update --no-cache && \
    apk add git autoconf automake alpine-sdk ncurses-dev ncurses-static && \
    git clone https://github.com/spurin/cmatrix.git . && \
    autoreconf -i && \
    mkdir -p /usr/lib/kbd/consolefonts /usr/share/consolefonts && \
    ./configure LDFLAGS="-static" && \
    make

#cmatrix Container Image
FROM alpine

LABEL org.opencontainers.image.authors="Nikolaos Bellias" \
      org.opencontainers.image.description="Container image for https://github.com/nbellias/cmatrix"

RUN apk update --no-cache && \
    apk add ncurses-terminfo-base && \
    adduser -g "Nikolaos Bellias" -s /usr/sbin/nologin -D -H cmatrix && \
    rm -rf /var/cache/apk/*

COPY --from=cmatrixbuilder /cmatrix/cmatrix /usr/local/bin/cmatrix

USER cmatrix
ENTRYPOINT [ "cmatrix" ]
CMD ["-b"]