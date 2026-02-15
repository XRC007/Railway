FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    openjdk-21-jre-headless \
    wget \
    htop \
    libgl1 \
    libglx-mesa0 \
    libgl1-mesa-dri \
    libxkbcommon-x11-0 \
    ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set software rendering
ENV LIBGL_ALWAYS_SOFTWARE=1

# Download SheepIt
RUN wget https://www.sheepit-renderfarm.com/media/applet/client-launcher-jar.php -O /app/sheepit.jar

# Set working directory
WORKDIR /app

# Copy start script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Run SheepIt
CMD ["/app/start.sh"]
