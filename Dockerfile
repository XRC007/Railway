FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install ALL dependencies for headless Blender rendering
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

# Set software rendering (CRITICAL for CPU-only containers)
ENV LIBGL_ALWAYS_SOFTWARE=1
ENV GALLIUM_DRIVER=llvmpipe

# Set working directory
WORKDIR /app

# Download SheepIt
RUN wget https://www.sheepit-renderfarm.com/media/applet/client-launcher-jar.php -O sheepit.jar

# Copy start script
COPY start.sh .
RUN chmod +x start.sh

# Run SheepIt
CMD ["./start.sh"]
