#!/bin/zsh -l

echo "Generating identifiers for Colors and Images"
mint run swiftgen run xcassets "DevStack/Resources/Colors.xcassets" "DevStack/Resources/Images.xcassets" -t swift4 --param publicAccess --output "DevStack/Constants/Assets.swift"
mint run swiftgen run xcassets "PresentationLayer/Resources/Colors.xcassets" "PresentationLayer/Resources/Images.xcassets" -t swift4 --param publicAccess --output "PresentationLayer/Resources/Constants/Assets.swift"

echo "Generating identifiers for Localizable"
mint run swiftgen run strings "DevStack/Resources/Base.lproj/Localizable.strings" -p "scripts/swiftgen-strings.stencil" --param publicAccess --output "DevStack/Constants/Localizable.swift"
mint run swiftgen run strings "PresentationLayer/Resources/Base.lproj/Localizable.strings" -p "scripts/swiftgen-strings.stencil" --param publicAccess --output "PresentationLayer/Resources/Constants/Localizable.swift"

echo "Generating identifiers for Storyboards"
mint run swiftgen run ib "DevStack" -t scenes-swift4 --output "DevStack/Constants/Storyboards.swift"
mint run swiftgen run ib "PresentationLayer" -t scenes-swift4 --output "PresentationLayer/Resources/Constants/Storyboards.swift"
