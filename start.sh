#!/bin/bash

# Get number of CPU cores
CORES=$(nproc)

# Run SheepIt (Railway will provide environment variables)
java -jar sheepit.jar \
  -login "${SHEEPIT_LOGIN}" \
  -password "${SHEEPIT_PASSWORD}" \
  -ui oneLine \
  -compute-method CPU \
  -cores ${CORES}
