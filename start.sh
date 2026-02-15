#!/bin/bash

# Get number of CPU cores (limit to 2 for Railway free tier)
CORES=$(nproc)
if [ $CORES -gt 2 ]; then
    CORES=2
fi

echo "Starting SheepIt with $CORES cores..."

# Run SheepIt with memory limit and verbose output
java -Xmx512m -jar sheepit.jar \
  -login "${SHEEPIT_LOGIN}" \
  -password "${SHEEPIT_PASSWORD}" \
  -ui oneLine \
  -compute-method CPU \
  -cores ${CORES} \
  -memory 256 \
  -verbose
