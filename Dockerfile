FROM alpine:3.4
COPY install.sh run.sh /opt/dataeducation/
RUN ["/bin/sh", "/opt/dataeducation/install.sh"]
ENTRYPOINT ["/bin/sh", "/opt/dataeducation/run.sh"]