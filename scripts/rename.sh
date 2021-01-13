#!/bin/bash

cd "$(dirname "$0")"

old_name="DevStack"
old_name_lowercase=`echo "${old_name}" | tr '[:upper:]' '[:lower:]'`

echo -n "Enter new name: "
read new_name
new_name_lowercase=`echo "${new_name}" | tr '[:upper:]' '[:lower:]'`

echo "Renaming root folder"
mv ../${old_name} ../${new_name}

echo "Renaming workspace"
mv ../${old_name}.xcworkspace ../${new_name}.xcworkspace
sed -i '' -e "s/${old_name}/${new_name}/g" ../${new_name}.xcworkspace/contents.xcworkspacedata

echo "Renaming project"
mv ../${old_name}.xcodeproj ../${new_name}.xcodeproj
sed -i '' -e "s/${old_name}/${new_name}/g" ../${new_name}.xcodeproj/project.pbxproj
sed -i '' -e "s/${old_name_lowercase}/${new_name_lowercase}/g" ../${new_name}.xcodeproj/project.pbxproj

echo "Renaming schemes"
mv ../${new_name}.xcodeproj/xcshareddata/xcschemes/${old_name}_Alpha.xcscheme ../${new_name}.xcodeproj/xcshareddata/xcschemes/${new_name}_Alpha.xcscheme
sed -i '' -e "s/${old_name}/${new_name}/g" ../${new_name}.xcodeproj/xcshareddata/xcschemes/${new_name}_Alpha.xcscheme
mv ../${new_name}.xcodeproj/xcshareddata/xcschemes/${old_name}_Beta.xcscheme ../${new_name}.xcodeproj/xcshareddata/xcschemes/${new_name}_Beta.xcscheme
sed -i '' -e "s/${old_name}/${new_name}/g" ../${new_name}.xcodeproj/xcshareddata/xcschemes/${new_name}_Beta.xcscheme
mv ../${new_name}.xcodeproj/xcshareddata/xcschemes/${old_name}.xcscheme ../${new_name}.xcodeproj/xcshareddata/xcschemes/${new_name}.xcscheme
sed -i '' -e "s/${old_name}/${new_name}/g" ../${new_name}.xcodeproj/xcshareddata/xcschemes/${new_name}.xcscheme

echo "Renaming entitlements"
mv ../${new_name}/App/Config/Alpha/${old_name}.entitlements ../${new_name}/App/Config/Alpha/${new_name}.entitlements
mv ../${new_name}/App/Config/Beta/${old_name}.entitlements ../${new_name}/App/Config/Beta/${new_name}.entitlements
mv ../${new_name}/App/Config/Production/${old_name}.entitlements ../${new_name}/App/Config/Production/${new_name}.entitlements

echo "Renaming support files"
sed -i '' -e "s/${old_name}/${new_name}/g" ../scripts/twine.sh
sed -i '' -e "s/${old_name_lowercase}/${new_name_lowercase}/g" ../scripts/twine.sh
sed -i '' -e "s/${old_name}/${new_name}/g" ../scripts/swiftgen.sh
sed -i '' -e "s/${old_name}/${new_name}/g" ../scripts/swiftgen-analyze.sh
sed -i '' -e "s/${old_name}/${new_name}/g" ../fastlane/Fastfile
sed -i '' -e "s/${old_name_lowercase}/${new_name_lowercase}/g" ../fastlane/Fastfile
sed -i '' -e "s/${old_name}/${new_name}/g" ../scripts/setup.sh

echo "✅ Renaming successful"
echo "!!! Replace GoogleService-Info plists and ensure that twine directory exists !!!"
