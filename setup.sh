#!/bin/bash

echo "Installing gems..."
bundle install --path vendor/bundle
echo "Installing pods..."
bundle exec pod install
