FROM debian:bookworm-slim

ARG BLIGHTFALL_VERSION=3.1.1

ENV JAVA_HOME=/opt/java/openjdk
COPY --from=eclipse-temurin:21 $JAVA_HOME $JAVA_HOME
ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -yqq curl unzip

RUN curl -s -o blightfall.zip https://servers.technicpack.net/Technic/servers/blightfall/Blightfall_Server_${BLIGHTFALL_VERSION}-CE.zip 
RUN unzip blightfall.zip -d /blightfall
RUN chmod +x /blightfall/start.sh
WORKDIR /blightfall
#RUN mv Blightfall_Server_${BLIGHTFALL_VERSION}-CE/* ~/

VOLUME ["/blightfall/world"]

STOPSIGNAL SIGTERM

ENTRYPOINT [ "/blightfall/start.sh" ]
#HEALTHCHECK --interval=5s --timeout=30s --start-period=1m --retries=24 CMD mc-health

