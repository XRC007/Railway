FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install ALL dependencies for Blender rendering
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
    libdrm2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set software rendering
ENV LIBGL_ALWAYS_SOFTWARE=1
ENV GALLIUM_DRIVER=llvmpipe

# Create working directory FIRST
WORKDIR /app

# Now download SheepIt (directory exists now)
RUN wget https://www.sheepit-renderfarm.com/media/applet/client-launcher-jar.php -O sheepit.jar

# Create start script directly in Dockerfile
RUN echo '#!/bin/bash\n\
CORES=$(nproc)\n\
if [ $CORES -gt 2 ]; then CORES=2; fi\n\
echo "Starting SheepIt with $CORES cores..."\n\
java -Xmx512m -jar sheepit.jar \\\n\
  -login "${SHEEPIT_LOGIN}" \\\n\
  -password "${SHEEPIT_PASSWORD}" \\\n\
  -ui oneLine \\\n\
  -compute-method CPU \\\n\
  -cores ${CORES} \\\n\
  -memory 256 \\\n\
  -verbose' > start.sh && chmod +x start.sh

CMD ["./start.sh"]
