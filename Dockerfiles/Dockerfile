FROM ubuntu:24.04


# Install needed packages
RUN apt-get -qqy update && apt-get -qqy install --no-install-recommends \
    socat \
    supervisor \
    openjdk-17-jdk-headless \
    wget \
    unzip \
    libxcomposite-dev \
    openbox \
    x11vnc \
    menu \
    xvfb \
    && apt autoremove -y \
    && apt clean all \
    && rm -rf /var/lib/apt/lists/*

# Setup SDK environment and device image
ARG COMMAND_LINE_TOOLS_VERSION=13114758

ENV ANDROID_HOME=/opt/android-sdk
ENV PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools"
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-${COMMAND_LINE_TOOLS_VERSION}_latest.zip \
        -O /tmp/command_line_tools.zip \
    && unzip -q /tmp/command_line_tools.zip -d ${ANDROID_HOME}/cmdline-tools \
    && mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest \
    && rm /tmp/command_line_tools.zip

RUN yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" "platforms;android-34" \
    "system-images;android-34;google_apis;x86_64" "emulator"


RUN mkdir -p /var/log/devicebox

RUN mkdir /opt/devicebox/
COPY configs /opt/devicebox/configs

COPY entrypoint.sh /opt/devicebox/entrypoint.sh

# Setup display environment variables
ENV DISPLAY=:0 \
    SCREEN_NUMBER=0 \
    SCREEN_WIDTH=1600 \
    SCREEN_HEIGHT=900 \
    SCREEN_DEPTH=24+32 \
    VNC_PORT=5900 \
    WEB_VNC_PORT=6080

EXPOSE 5900 6080

CMD ["bash", "/opt/devicebox/entrypoint.sh"]
