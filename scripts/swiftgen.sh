#!/bin/bash

echo "Generating identifiers for Colors and Images..."
$PODS_ROOT/SwiftGen/bin/swiftgen xcassets "DevStack/Resources/Colors.xcassets" "DevStack/Resources/Images.xcassets" -t swift4 --param publicAccess --output "DevStack/Constants/Assets.swift"

echo "Generating identifiers for Localizable..."
$PODS_ROOT/SwiftGen/bin/swiftgen strings "DevStack/Resources/Base.lproj/Localizable.strings" -p "scripts/swiftgen-strings.stencil" --param publicAccess --output "DevStack/Constants/Localizable.swift"

echo "Generating identifiers for Storyboards..."
$PODS_ROOT/SwiftGen/bin/swiftgen ib "DevStack" -t scenes-swift4 --output "DevStack/Constants/Storyboards.swift"

echo "Fixing Storyboard identifiers for all targets..."
sed -i '' -e 's/A_DevStack.//g;s/B_DevStack.//g;s/DevStack.//g;s/import A_DevStack//g;s/import B_DevStack//g;s/import DevStack//g;' DevStack/Constants/Storyboards.swift
