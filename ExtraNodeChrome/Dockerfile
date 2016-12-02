FROM unravel/node-base:3.0.1
MAINTAINER Selenium <selenium-developers@googlegroups.com>

USER root

#===============
# Google Chrome
#===============
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install \
    google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/*

#==================
# Chrome webdriver
#==================
ENV CHROME_DRIVER_VERSION 2.25
RUN wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

#========================
# Selenium Configuration
#========================
COPY config.json /opt/selenium/config.json

#=================================
# Chrome Launch Script Modication
#=================================
COPY chrome_launcher.sh /opt/google/chrome/google-chrome
RUN chmod +x /opt/google/chrome/google-chrome

#==========
# Selenium
#==========
RUN  wget --no-verbose https://github.com/groupon/Selenium-Grid-Extras/releases/download/v1.12.7/SeleniumGridExtras-1.12.7-SNAPSHOT-jar-with-dependencies.jar -O /opt/selenium/selenium-server-standalone.jar

# xtra
RUN mkdir /opt/selenium/log
RUN mkdir /opt/selenium/video_output
RUN mkdir /opt/selenium/shared

#COPY cached_release_list.json /opt/selenium/cached_release_list.json
COPY selenium_grid_extras_config.json /opt/selenium/selenium_grid_extras_config.json
WORKDIR /opt/selenium
# /xtra

RUN chown -R seluser /opt/selenium
USER seluser
# Following line fixes
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
