FROM eclipse-temurin:8-jre

ARG BLIGHTFALL_VERSION=3.1.1

#ENV JAVA_HOME=/opt/java/openjdk
#COPY --from=eclipse-temurin:21 $JAVA_HOME $JAVA_HOME
#ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -yqq curl unzip

RUN curl -s -o blightfall.zip https://servers.technicpack.net/Technic/servers/blightfall/Blightfall_Server_${BLIGHTFALL_VERSION}-CE.zip 
RUN unzip blightfall.zip -d /blightfall

WORKDIR /blightfall

RUN echo "eula=true" > eula.txt

EXPOSE 25565
VOLUME ["/blightfall/world"]

STOPSIGNAL SIGTERM

ENTRYPOINT [ "java", "-Dlog4j.configurationFile=/blightfall/log4j2_server.xml", "-Xmx3G", "-Xms2G", "-jar", "Blightfall.jar", "nogui" ]
#HEALTHCHECK --interval=5s --timeout=30s --start-period=1m --retries=24 CMD mc-health

