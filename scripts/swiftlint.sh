SWIFT_LINT="${PODS_ROOT}/SwiftLint/swiftlint"
SWIFT_LINT_CONFIG="${PODS_ROOT}/../.swiftlint.yml"

if which ${SWIFT_LINT} >/dev/null; then
    ${SWIFT_LINT} autocorrect && ${SWIFT_LINT} --config ${SWIFT_LINT_CONFIG}
else
    echo "error: SwiftLint not installed, 'pod install' or download from https://github.com/realm/SwiftLint"
    exit 1
fi
