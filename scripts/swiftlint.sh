#!/bin/zsh -l

echo "Running SwiftLint"
mint run swiftlint autocorrect && mint run swiftlint --config .swiftlint.yml
