# QEST iOS DevStack

## Documents
- **API Doc:** [Postmanerator](https://qest-devstack.herokuapp.com/apidoc.html)
- **Specification:** FIXME
- **Graphics:** FIXME
- **Assets**: FIXME

## ALPHA

### Configuration
- **BundleID:** cz.qest.devstack.alpha
- **API endpoint:** FIXME

### Test accounts
FIXME

## BETA

### Configuration
- **BundleID:** cz.qest.devstack.beta
- **API endpoint:** FIXME

### Test accounts
FIXME

## PRODUCTION

### Configuration
- **BundleID:** cz.qest.devstack
- **API endpoint:** FIXME

### Test accounts
FIXME

## RubyGems + CocoaPods
- First of all you should have installed Ruby version 2.5.3 or newer (you can easily manage your Ruby versions with [rbenv](https://github.com/rbenv/rbenv))
- All ruby gems used in the project (cocoapods, twine, fastlane, ..) are installed via [Bundler](http://bundler.io/)
- Individual gems are specified in the `Gemfile` and `Gemfile.lock` and can be installed with `bundle install --path vendor/bundle`
- Any of the installed gems can be started with `bundle exec` (for example `bundle exec pod install --repo-update` for CocoaPods)
- Only the `Gemfile/Gemfile.lock` and `Podfile/Podfile.lock` should be committed (Do not commit `Pods` and `vendor` directories!)
- You can use the `scripts/setup.sh` for quick setup of all required gems and pods
- There is also `scripts/rename.sh` for quick renaming from DevStack to YourProject

## Architecture (MVVM)
- Service Layer is composed from individual microservices (LoginService, UserService, etc.)
- Individual microservices obtains data either from the database or from the API depending on the specific use case
- Network communication is based on [Moya](https://github.com/Moya/Moya) network framework
- Model layer is represented via [Realm](https://github.com/realm/realm-cocoa) object models and native Decodable is used for mapping from JSON
- Asynchronous functions in microservices are represented as observables with the [RxSwift](https://github.com/ReactiveX/RxSwift) framework
- Those observables usually combines stream from the database and stream from a network call
- Microservices are injected into ViewModels with the FlowController pattern
- ViewModel has properties, methods to change them and observables which are then observed in relevant ViewControllers

## Style Guide
- [Swift Style Guide](https://github.com/raywenderlich/swift-style-guide)
- To ensure a uniform style, it is advisable to use the ready-made templates for ViewController / ViewModel / FlowController etc.
- The templates are available from a separate repository [ios-templates](https://github.com/pchmelar/ios-templates)
- When using storyboards, strictly go with the rule `one view = one storyboard`!
- Project structure in the Xcode should reflect the directory structure on your drive
- Unfinished or broken code should be marked with `#warning("TODO:")` or `#warning("FIXME:")`
- Identifiers for storyboard, assets, colors and localized strings are generated with [SwiftGen](https://github.com/SwiftGen/SwiftGen)

## Localization
- All strings in the application are localized and shared with the Android team via [Twine](https://github.com/scelis/twine)
- Strings are stored in the file `strings.txt` in the separate repository [twine-localization](https://qest.visualstudio.com/Qest/_git/twine-localization)
- Path to the `twine-localization` folder is loaded from the bash variable `TWINE_FOLDER`
- Add this line `export TWINE_FOLDER=<PATH_TO_TWINE_FOLDER>` into your `~/.bash_profile`
- The build phase script then generates appropriate `Localizable.strings` files from the mentioned `strings.txt` file
- When modifying `strings.txt` it is required to comply with the specified syntax and to pull/push all the changes frequently

## Build + Release
- CI/CD process is based on Azure DevOps and [Fastlane](https://fastlane.tools/)
- Main configuration for Fastlane is in the `fastlane/Fastfile` file
- Build branch should be created from the actual develop branch - `git checkout -b 'build/1.2.3'`
- The build is started right after the push - `git push origin build/1.2.3`
- Version number is automatically set based on the branch name (for example `1.2.3` for the branch `build/1.2.3`)
- Build number is generated on the CI server, the values set in the Xcode are ignored
- The builds for all environments (alpha/beta/production) are produced and alpha version is released via TestFlight
- Used build branch should be merged back to the develop branch if any changes are made

## TODO
- Switch CocoaPods to CDN after [1.8.0 release](http://blog.cocoapods.org/CocoaPods-1.8.0-beta/)
- Update Pods after [Moya 14.0.0 release](https://github.com/Moya/Moya/releases)
- Migrate to SwiftUI + Combine when the time is right (not before iOS 14.0 official release)
- Provide example unit tests
