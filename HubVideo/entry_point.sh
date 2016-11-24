#!/bin/bash

ROOT=/opt/selenium
CONF=$ROOT/config.json

$ROOT/generate_config >$CONF
echo "starting selenium hub with configuration:"
cat $CONF

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

function shutdown {
    echo "shutting down hub.."
    kill -s SIGTERM $NODE_PID
    wait $NODE_PID
    echo "shutdown complete"
}

#java ${JAVA_OPTS} -jar /opt/selenium/selenium-server-standalone.jar \
#  -role hub \
#  -hubConfig $CONF \
#  ${SE_OPTS} &

# https://github.com/aimmac23/selenium-video-node/blob/master/INSTALLATION.md
# http://stackoverflow.com/questions/11922681/differences-between-java-cp-and-java-jar
# /!\ video-node docs references v2.0
java -cp /opt/selenium/selenium-video-node-2.1.jar:/opt/selenium/selenium-server-standalone.jar \
    org.openqa.grid.selenium.GridLauncherV3 -servlets com.aimmac23.hub.servlet.HubVideoDownloadServlet \
  -role hub \
  -hubConfig $CONF \
  ${SE_OPTS} &

NODE_PID=$!

trap shutdown SIGTERM SIGINT
wait $NODE_PID

