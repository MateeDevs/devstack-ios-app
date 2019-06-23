#!/bin/bash

echo "Updating gems..."
bundle update

echo "Updating pods..."
bundle exec pod update --repo-update

echo "Cleaning up old gems..."
bundle clean
