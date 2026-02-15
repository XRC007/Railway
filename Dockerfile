FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install all working Blender dependencies
RUN apt-get update && \
    apt-get install -y \
    openjdk-21-jre-headless \
    wget \
    htop \
    ca-certificates \
    libgl1-mesa-glx \
    libgl1 \
    libglx-mesa0 \
    libgl1-mesa-dri \
    libglu1-mesa \
    mesa-utils \
    libxrender1 \
    libxi6 \
    libxrandr2 \
    libxfixes3 \
    libxcursor1 \
    libxinerama1 \
    libxxf86vm1 \
    libxkbcommon-x11-0 \
    libxkbcommon0 \
    libsm6 \
    libice6 \
    libgomp1 \
    libopenexr25 \
    libpng16-16 \
    libjpeg-turbo8 \
    libtiff5 \
    libavdevice58 \
    libavformat58 \
    libavcodec58 \
    libswscale5 \
    libavutil56 \
    libfftw3-single3 \
    libx11-6 \
    libxext6 \
    libxt6 \
    libx11-xcb1 \
    libxcb1 \
    libxcb-glx0 \
    libxcb-dri2-0 \
    libxcb-dri3-0 \
    libxcb-present0 \
    libxcb-sync1 \
    libxshmfence1 \
    libdrm2 \
    libtbb2 \
    libfreetype6 \
    libfontconfig1 \
    libglib2.0-0 \
    libharfbuzz0b \
    libbz2-1.0 \
    zlib1g \
    libjemalloc2 \
    libspnav0 \
    libopenal1 \
    libsdl2-2.0-0 \
    libpugixml1v5 \
    libboost-filesystem1.74.0 \
    libboost-locale1.74.0 \
    libboost-regex1.74.0 \
    libboost-system1.74.0 \
    libboost-thread1.74.0 \
    libblosc1 \
    libpotrace0 \
    libgmp10 \
    libmpfr6 \
    libxml2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set software rendering
ENV LIBGL_ALWAYS_SOFTWARE=1
ENV GALLIUM_DRIVER=llvmpipe
ENV MESA_GL_VERSION_OVERRIDE=3.3

WORKDIR /app

# Download SheepIt
RUN wget https://www.sheepit-renderfarm.com/media/applet/client-launcher-jar.php -O sheepit.jar

# Create start script with logging
RUN echo '#!/bin/bash\n\
CORES=$(nproc)\n\
if [ $CORES -gt 2 ]; then CORES=2; fi\n\
echo "Starting SheepIt with $CORES cores..."\n\
echo "Available memory: $(free -h | grep Mem)"\n\
java -Xmx512m -jar sheepit.jar \\\n\
  -login "${SHEEPIT_LOGIN}" \\\n\
  -password "${SHEEPIT_PASSWORD}" \\\n\
  -ui oneLine \\\n\
  -compute-method CPU \\\n\
  -cores ${CORES} \\\n\
  -memory 512 \\\n\
  --log-stdout' > start.sh && chmod +x start.sh

CMD ["./start.sh"]
