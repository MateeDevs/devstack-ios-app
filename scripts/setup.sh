#!/bin/bash

cd "$(dirname "$0")"

echo "Creating files for Twine and SwiftGen"
find ../DevStack/Resources/*.lproj -type d -exec sh -c 'touch $0/Localizable.strings' {} \;
touch ../DevStack/Constants/Assets.swift
touch ../DevStack/Constants/Localizable.swift
touch ../DevStack/Constants/Storyboards.swift

echo "Checking whether Homebrew is installed"
if command -v brew &> /dev/null; then
  echo "✅ Homebrew is installed"
else
  echo "❌ Homebrew is not installed"
  echo "Please visit https://brew.sh for more info"
  exit
fi

echo "Checking whether Twine is installed"
if command -v twine &> /dev/null; then
  echo "✅ Twine is installed"
else
  echo "❌ Twine is not installed - installing now"
  gem install twine
fi

echo "Checking whether Mint is installed"
if command -v mint &> /dev/null; then
  echo "✅ Mint is installed"
else
  echo "❌ Mint is not installed - installing now"
  brew install mint
fi

echo "Bootstraping Mint dependencies"
cd ..
mint bootstrap
