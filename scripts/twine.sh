#!/bin/zsh -l

echo "Generating Localizable files for specified languages"
twine generate-localization-file $TWINE_FOLDER/devstack/strings.txt PresentationLayer/Sources/PresentationLayer/Resources/Base.lproj/Localizable.strings --lang en
twine generate-localization-file $TWINE_FOLDER/devstack/strings.txt PresentationLayer/Sources/PresentationLayer/Resources/cs.lproj/Localizable.strings --lang cs
twine generate-localization-file $TWINE_FOLDER/devstack/strings.txt PresentationLayer/Sources/PresentationLayer/Resources/sk.lproj/Localizable.strings --lang sk
twine generate-localization-file $TWINE_FOLDER/devstack/strings.txt PresentationLayer/Sources/PresentationLayer/Resources/en.lproj/Localizable.strings --lang en
