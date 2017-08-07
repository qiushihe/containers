FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash git \
  && apk add "nodejs<7.0.0"

# Cleanup apk
RUN rm -rf /var/cache/apk/*

# Setup LE-Servo
ENV LE_SERVO_CHECKOUT af022b685eafa0d897ca017f1271b4db9f6bb73a
RUN rm -fr /le-servo \
  && git clone https://github.com/qiushihe/le-servo.git /le-servo \
  && cd /le-servo \
  && git checkout $LE_SERVO_CHECKOUT \
  && npm install \
  && npm run build

# =================================================================================================

EXPOSE 80

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
