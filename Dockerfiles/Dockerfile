FROM ubuntu:24.04


# Install needed packages
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
RUN apt-get -qqy update && apt-get -qqy install --no-install-recommends \
    socat \
    supervisor \
    openjdk-17-jdk-headless \
    curl \
    wget \
    unzip \
    libxcomposite-dev \
    openbox \
    x11vnc \
    menu \
    xvfb \
    novnc \
    libpulse0 \
    nodejs \
    && apt autoremove -y \
    && apt clean all \
    && rm -rf /var/lib/apt/lists/*

# Setup SDK environment and device image
ARG ANDROID_VERSION
ARG ANDROID_API_LEVEL
ARG COMMAND_LINE_TOOLS_VERSION=13114758

ENV ANDROID_VERSION=${ANDROID_VERSION}
ENV ANDROID_API_LEVEL=${ANDROID_API_LEVEL}
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools"
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-${COMMAND_LINE_TOOLS_VERSION}_latest.zip \
        -O /tmp/command_line_tools.zip \
    && unzip -q /tmp/command_line_tools.zip -d ${ANDROID_HOME}/cmdline-tools \
    && mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest \
    && rm /tmp/command_line_tools.zip

RUN yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" "platforms;android-${ANDROID_API_LEVEL}" \
    "system-images;android-${ANDROID_API_LEVEL};google_apis;x86_64" "emulator"

RUN npm install -g appium && \
    appium driver install uiautomator2

# Download noVNC package
ARG NOVNC_VERSION="1.6.0"
RUN  wget -nv -O noVNC.zip "https://github.com/novnc/noVNC/archive/refs/tags/v${NOVNC_VERSION}.zip" \
    && unzip -x noVNC.zip \
    && rm noVNC.zip  \
    && mv noVNC-${NOVNC_VERSION} /opt/noVNC \
    && ln /opt/noVNC/vnc.html /opt/noVNC/index.html

# Setup display environment variables
ENV DISPLAY=:0 \
    SCREEN_NUMBER=0 \
    SCREEN_WIDTH=1600 \
    SCREEN_HEIGHT=900 \
    SCREEN_DEPTH=24+32 \
    VNC_PORT=5900 \
    WEB_VNC_PORT=6080

# Setup and copy needed files and directories
RUN mkdir -p /var/log/devicebox

RUN mkdir /opt/devicebox/
COPY configs /opt/devicebox/configs
COPY scripts /opt/devicebox/scripts

RUN ln -s ${ANDROID_HOME}/emulator/emulator /usr/bin/

COPY entrypoint.sh /opt/devicebox/entrypoint.sh

# Expose ports
EXPOSE 5900 6080 5555 4723


CMD ["bash", "/opt/devicebox/entrypoint.sh"]
