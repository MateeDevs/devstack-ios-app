#!/bin/bash

cd "$(dirname "$0")"

echo "Setup git to ignore generated files..."
git update-index --skip-worktree ../DevStack/Constants/*
find ../DevStack/Resources -name 'Localizable.strings' -exec sh -c 'git update-index --skip-worktree $0' {} \;

echo "Installing gems..."
bundle config --local path vendor/bundle
bundle install

echo "Installing pods..."
bundle exec pod install --repo-update

echo "Cleaning up old gems..."
bundle clean
