FROM gitpod/workspace-full

RUN sudo apt-get update

ARG FIREFOX_VERSION=75.0

RUN sudo wget --no-verbose -O /tmp/firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2RUN sudo tar -C /opt -xjf /tmp/firefox.tar.bz2 \
    && sudo rm /tmp/firefox.tar.bz2 \
    && sudo ln -fs /opt/firefox/firefox /usr/bin/firefox

FROM gitpod/workspace-postgres



# Install custom tools, runtimes, etc.
# For example "bastet", a command-line tetris clone:
# RUN brew install bastet
#
# More information: https://www.gitpod.io/docs/config-docker/
USER gitpod

