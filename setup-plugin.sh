#!/usr/bin/env bash
set -e

VENDOR=$1
MODE=$2 # --fresh or --existing

if [ -z "$VENDOR" ] || [ -z "$MODE" ]; then
  echo "Usage: ./setup-plugin.sh <vendor> [--fresh|--existing]"
  exit 1
fi

PLUGIN_FOLDER=$(pwd)
PLUGIN_NAME=$(basename "$PLUGIN_FOLDER")

echo "Script triggered"
echo "Plugin folder: $PLUGIN_FOLDER"
echo "Plugin name: $PLUGIN_NAME"
echo "Vendor: $VENDOR"
echo "Mode: $MODE"

# Update vendor in composer.json
if [ -f composer.json ]; then
  echo "Updating composer.json vendor..."
  jq ".name = \"$VENDOR/$PLUGIN_NAME\"" composer.json > composer.tmp && mv composer.tmp composer.json
fi

# Update vendor in package.json
if [ -f package.json ]; then
  echo "Updating package.json vendor..."
  jq ".name = \"$VENDOR/$PLUGIN_NAME\"" package.json > package.tmp && mv package.tmp package.json
fi

# Install dependencies
if [ -f composer.json ]; then
  echo "Installing PHP dependencies..."
  composer install
fi

if [ -f package.json ]; then
  echo "Installing Node dependencies..."
  npm install
fi

echo "Setup complete."