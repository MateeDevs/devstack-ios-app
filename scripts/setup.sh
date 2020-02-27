#!/bin/bash

cd "$(dirname "$0")"

echo "Installing gems..."
bundle config --local path vendor/bundle
bundle install

echo "Installing pods..."
bundle exec pod install --repo-update

echo "Cleaning up old gems..."
bundle clean
