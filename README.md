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
- Vsechny ruby gems pouzivane v projektu (cocoapods, twine, fastlane, ..) instalujeme pres [Bundler](http://bundler.io/)
- Jednotlive gemy jsou specifikovane v Gemfile a Gemfile.lock a nainstaluji se prikazem `bundle install --path vendor/bundle`
- Jakykoli z nainstalovanych gemu je mozne spustit prikazem `bundle exec` (napr. `bundle exec pod install` pro cocoapods)
- Commitujeme pouze Gemfile/Gemfile.lock a Podfile/Podfile.lock (adresare Pods a vendor ne!)

## Style Guide
- [Swift Style Guide](https://github.com/raywenderlich/swift-style-guide)
- Nedokoncene nebo nefunkcni casti kodu oznacujeme komentarem // TODO: nebo // FIXME:
- Struktura projektu v XCode by mela odpovidat adresarove strukture na disku
- Identifikatory pro storyboardy, assety, barvy a lokalizovane texty generujeme prostrednictvim SwiftGen

## Lokalizace
- Texty v aplikaci jsou lokalizovane a sdilene s Android tymem prostrednictvim [Twine](https://github.com/scelis/twine)
- Vsechny texty jsou ulozene v jedinem souboru strings.txt, ktery se nachazi v samostatnem repozitari twine-localization
- Cesta k repozitari twine-localization je nactena z bash promenne TWINE_FOLDER (je nutne pridat do ~/.bash_profile)
- Pri buildu aplikace je spusten script, ktery ze souboru strings.txt vygeneruje prislusne Localizable.strings soubory
- Pri modifikaci souboru strings.txt je nutne dodrzovat stanovenou syntaxi a veskere zmeny pravidelne pullovat/pushovat

## Service Layer
- TODO

## Build + Release
- Projekt vyuziva CI/CD pomoci Visual Studio Team Services a [Fastlane](https://fastlane.tools/)
- Hlavni konfigurace pro Fastlane se nachazi v souboru fastlane/Fastfile
- Pro vydani nove verze aplikace je nutne nejprve nastavit pozadovane cislo verze a buildu prostrednictvim Xcode
- Commit, ze ktereho bude sestaven build, je nutne otagovat prikazem: `git tag -a 'build/1.0(1)' -m 'tag message'`
- Pro spusteni buildu staci pushnout otagovany commit prikazem `git push origin YOUR_BRANCH --tags`
- Automaticky dojde k buildu alpha/beta/production verze a releasu alpha verze prostrednictvim Testflight
