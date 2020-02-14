SWIFT_LINT="${PODS_ROOT}/SwiftLint/swiftlint"
SWIFT_LINT_CONFIG="${PODS_ROOT}/../.swiftlint.yml"

if which swiftlint >/dev/null; then
    ${SWIFT_LINT} --config ${SWIFT_LINT_CONFIG} && ${SWIFT_LINT} autocorrect
else
    echo "warning: SwiftLint not installed, 'pod install' or download from https://github.com/realm/SwiftLint"
fi
