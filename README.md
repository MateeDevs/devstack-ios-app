# Matee iOS DevStack

## Documents
- **API Doc:** [Postmanerator](https://matee-devstack.herokuapp.com/apidoc.html)
- **Specification:** FIXME
- **Graphics:** FIXME
- **Assets**: FIXME

## ALPHA

### Configuration
- **BundleID:** cz.matee.devstack.alpha
- **API endpoint:** FIXME

### Test accounts
FIXME

## BETA

### Configuration
- **BundleID:** cz.matee.devstack.beta
- **API endpoint:** FIXME

### Test accounts
FIXME

## PRODUCTION

### Configuration
- **BundleID:** cz.matee.devstack
- **API endpoint:** FIXME

### Test accounts
FIXME

## RubyGems + CocoaPods
- First of all you should have installed Ruby version 2.5.3 or higher (you can easily manage your Ruby versions with [rbenv](https://github.com/rbenv/rbenv))
- You should also have installed rubygems version 3.0.0 or higher (you can update rubygems with `gem update --system`)
- All ruby gems used in the project (cocoapods, twine, fastlane, ..) are installed via [Bundler](http://bundler.io/)
- Individual gems are specified in the `Gemfile` and `Gemfile.lock` and can be installed with `bundle install --path vendor/bundle`
- Any of the installed gems can be started with `bundle exec` (for example `bundle exec pod install --repo-update` for CocoaPods)
- Only the `Gemfile/Gemfile.lock` and `Podfile/Podfile.lock` should be committed (Do not commit `Pods` and `vendor` directories!)
- You can use the `scripts/setup.sh` for quick setup of all required gems and pods
- There is also `scripts/rename.sh` for quick renaming from DevStack to YourProject

## Architecture (MVVM)
- Service Layer is composed from individual services (LoginService, UserService, etc.)
- Services obtains data through the providers (DatabaseProvider, NetworkProvider, etc.)
- Network communication is based on [Moya](https://github.com/Moya/Moya) network framework
- Data model is represented via [Realm](https://github.com/realm/realm-cocoa) object models and native Decodable is used for mapping from JSON
- Asynchronous functions in microservices are represented as observables with the [RxSwift](https://github.com/ReactiveX/RxSwift) framework
- Services are "injected" into ViewModels during the init via Dependencies typealias
- ViewModel has its inputs and outputs which are then binded or observed in a relevant ViewController

## Style Guide
- [Swift Style Guide](https://github.com/raywenderlich/swift-style-guide)
- Swiftlint is enabled for the whole codebase, you can find its configuration inside the `.swiftlint.yml`
- To ensure a uniform style, it is advised to use the ready-made templates for ViewController / ViewModel / FlowController etc.
- The templates are available from a separate repository [ios-templates](https://github.com/MateeDevs/devstack-ios-templates)
- When using storyboards, strictly go with the rule `one view = one storyboard`!
- Project structure in the Xcode should reflect the directory structure on your drive
- Unfinished or broken code should be marked with `#warning("TODO:")` or `#warning("FIXME:")`
- Identifiers for storyboard, assets, colors and localized strings are generated with [SwiftGen](https://github.com/SwiftGen/SwiftGen)

## Localization
- All strings in the application are localized and shared with the Android team via [Twine](https://github.com/scelis/twine)
- Strings are stored in the file `strings.txt` in the separate repository [twine-localization](https://github.com/MateeDevs/twine-localization)
- Path to the `twine-localization` folder is loaded from the bash variable `TWINE_FOLDER`
- Add this line `export TWINE_FOLDER=<PATH_TO_TWINE_FOLDER>` into your `~/.zshenv`
- The build phase script then generates appropriate `Localizable.strings` files from the mentioned `strings.txt` file
- When modifying `strings.txt` it is required to comply with the specified syntax and to pull/push all the changes frequently

## Push Notifications
- Push Notifications are sent via [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging)
- All received notifications are handled inside the FirebaseService
- Notifications can be easily tested with scripts from the [ios-push-tester](https://github.com/MateeDevs/ios-push-tester) repository

## Debug
- All important information should be logged using the default `os_log` (wrapper `Logger` is available for convenience)
- All network requests going through the `AuthenticatedProvider` are printed into the console in debug builds
- [Flipper](https://fbflipper.com/) with layout and network plugins is enabled for debug builds

## Build + Release
- CI/CD process is based on [GitHub Actions](https://github.com/features/actions) and [Fastlane](https://fastlane.tools/)
- Main configuration for GitHub Actions is in the `.github/workflows/main.yml` file
- Main configuration for Fastlane is in the `fastlane/Fastfile` file
- Builds can be triggered manually on the GitHub website
- Version number is automatically set based on the input in manual trigger
- Build number is generated on the CI server, the values set in the Xcode are ignored
- The builds for all environments (alpha/beta/production) are produced and uploaded to the TestFlight
- After successfull build, a git tag with version and build numbers is created and pushed to the git

## Tests
- Unit tests are in `DevStackTests`, you can run them on any scheme with `CMD + U`
- All new features should have at least a basic test set for ViewModel's outputs and all newly created service methods
- Mocking of network requests is based on [Moya stubbing provider](https://github.com/Moya/Moya/blob/master/docs/Testing.md)

## TODO
- Use `latest` in dSYM sync when [fixed](https://github.com/fastlane/fastlane/issues/17474)
- Migrate to SwiftPM when all used frameworks are available (waiting for [Firebase](https://github.com/firebase/firebase-ios-sdk/issues/3136))
- Migrate to SwiftUI + Combine when the time is right (not before iOS 14.0 official release)
