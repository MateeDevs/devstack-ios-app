#!/bin/zsh -i

echo "Generating Localizable files for specified languages..."
bundle exec twine generate-localization-file $TWINE_FOLDER/devstack/strings.txt ./DevStack/Resources/Base.lproj/Localizable.strings --lang en
bundle exec twine generate-localization-file $TWINE_FOLDER/devstack/strings.txt ./DevStack/Resources/cs.lproj/Localizable.strings --lang cs
bundle exec twine generate-localization-file $TWINE_FOLDER/devstack/strings.txt ./DevStack/Resources/sk.lproj/Localizable.strings --lang sk
bundle exec twine generate-localization-file $TWINE_FOLDER/devstack/strings.txt ./DevStack/Resources/en.lproj/Localizable.strings --lang en
