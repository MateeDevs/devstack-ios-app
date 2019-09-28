fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios provision_alpha
```
fastlane ios provision_alpha
```
Check Alpha provisiong profile
### ios provision_beta
```
fastlane ios provision_beta
```
Check Beta provisiong profile
### ios provision_production
```
fastlane ios provision_production
```
Check Production provisiong profile
### ios build_alpha
```
fastlane ios build_alpha
```
Create a new Alpha build
### ios build_beta
```
fastlane ios build_beta
```
Create a new Beta build
### ios build_production
```
fastlane ios build_production
```
Create a new Production build
### ios release_alpha
```
fastlane ios release_alpha
```
Release the Alpha build via TestFlight
### ios release_beta
```
fastlane ios release_beta
```
Release the Beta build via TestFlight
### ios release_production_testflight
```
fastlane ios release_production_testflight
```
Release the Production build via TestFlight
### ios release_production_appstore
```
fastlane ios release_production_appstore
```
Submit the Production build to the AppStore

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
