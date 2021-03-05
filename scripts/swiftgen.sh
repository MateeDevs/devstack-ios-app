#!/bin/zsh -l

echo "Generating identifiers for Colors and Images"
mint run swiftgen run xcassets "DevStack/Resources/Colors.xcassets" "DevStack/Resources/Images.xcassets" -t swift4 --param publicAccess --output "DevStack/Constants/Assets.swift"

echo "Generating identifiers for Localizable"
mint run swiftgen run strings "DevStack/Resources/Base.lproj/Localizable.strings" -p "scripts/swiftgen-strings.stencil" --param publicAccess --output "DevStack/Constants/Localizable.swift"

echo "Generating identifiers for Storyboards"
mint run swiftgen run ib "DevStack" -t scenes-swift4 --output "DevStack/Constants/Storyboards.swift"
