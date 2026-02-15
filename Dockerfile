FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install ALL dependencies needed for Blender rendering
RUN apt-get update && \
    apt-get install -y \
    openjdk-21-jre-headless \
    wget \
    htop \
    libgl1 \
    libglx-mesa0 \
    libgl1-mesa-dri \
    libxkbcommon-x11-0 \
    libxrender1 \
    libxi6 \
    libxrandr2 \
    libxfixes3 \
    libxcursor1 \
    libxinerama1 \
    libxxf86vm1 \
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
    ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set software rendering (important for CPU-only rendering)
ENV LIBGL_ALWAYS_SOFTWARE=1

# Set working directory
WORKDIR /app

# Download SheepIt
RUN wget https://www.sheepit-renderfarm.com/media/applet/client-launcher-jar.php -O sheepit.jar

# Copy start script
COPY start.sh .
RUN chmod +x start.sh

# Run SheepIt
CMD ["./start.sh"]
