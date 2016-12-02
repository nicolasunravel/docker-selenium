FROM unravel/selenium_base:3.0.1
MAINTAINER Selenium <selenium-developers@googlegroups.com>

#========================
# Selenium Configuration
#========================

EXPOSE 4444
EXPOSE 3000

ENV GRID_NEW_SESSION_WAIT_TIMEOUT -1
ENV GRID_JETTY_MAX_THREADS -1
ENV GRID_NODE_POLLING  5000
ENV GRID_CLEAN_UP_CYCLE 5000
ENV GRID_TIMEOUT 30000
ENV GRID_BROWSER_TIMEOUT 0
ENV GRID_MAX_SESSION 5
ENV GRID_UNREGISTER_IF_STILL_DOWN_AFTER 30000

#==========
# Selenium
#==========
RUN  mkdir -p /opt/selenium \
  && wget --no-verbose https://github.com/groupon/Selenium-Grid-Extras/releases/download/v1.12.7/SeleniumGridExtras-1.12.7-SNAPSHOT-jar-with-dependencies.jar -O /opt/selenium/selenium-server-standalone.jar

COPY generate_config /opt/selenium/generate_config
COPY entry_point.sh /opt/bin/entry_point.sh

# xtra
RUN mkdir /opt/selenium/configs
RUN mkdir /opt/selenium/log

# /xtra

RUN chown -R seluser /opt/selenium
COPY selenium_grid_extras_config.json /opt/selenium/selenium_grid_extras_config.json

USER seluser

CMD ["/opt/bin/entry_point.sh"]

