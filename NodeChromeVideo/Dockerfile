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

#===========================
# video recording capability
# https://github.com/aimmac23/selenium-video-node/blob/master/INSTALLATION.md
#===========================
RUN apt-get -qqy update && apt-get install -qqy wget
# video extension alongside the hub code
RUN wget http://repo1.maven.org/maven2/com/aimmac23/selenium-video-node/2.1/selenium-video-node-2.1.jar -O /opt/selenium/selenium-video-node-2.1.jar

#==============================
# Scripts to run Selenium Node
#==============================
COPY \
  entry_point.sh \
    /opt/bin/
RUN chmod +x /opt/bin/entry_point.sh


USER seluser
# Following line fixes
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
