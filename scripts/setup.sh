#!/bin/bash

cd "$(dirname "$0")"

echo "Creating files for Twine and SwiftGen"
find ../DevStack/Resources/*.lproj -type d -exec sh -c 'touch $0/Localizable.strings' {} \;
touch ../DevStack/Constants/Assets.swift
touch ../DevStack/Constants/Localizable.swift
touch ../DevStack/Constants/Storyboards.swift

echo "Installing gems..."
bundle config --local path vendor/bundle
bundle install

echo "Installing pods..."
bundle exec pod install --repo-update

echo "Cleaning up old gems..."
bundle clean
