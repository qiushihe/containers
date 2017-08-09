FROM alpine:3.6

RUN apk --update upgrade \
  && apk add bash git mongodb nodejs nodejs-npm \
  && npm install npm@latest -g

# Cleanup apk
RUN rm -rf /var/cache/apk/*

# Setup LE-Servo
ENV LE_SERVO_CHECKOUT master
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
