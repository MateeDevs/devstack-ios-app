#!/bin/bash

echo "Setup git to ignore generated files..."
git update-index --skip-worktree DevStack/Constants/*
find DevStack/Resources/*.lproj -type f -exec sh -c 'git update-index --skip-worktree $0' {} \;

echo "Installing gems..."
bundle install --path vendor/bundle

echo "Installing pods..."
bundle exec pod install --repo-update

echo "Cleaning up old gems..."
bundle clean
