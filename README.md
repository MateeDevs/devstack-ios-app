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
- Jakykoli z nainstalovanych gemu je mozne spustit prikazem `bundle exec` (napr. `bundle exec pod install --repo-update` pro cocoapods)
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
- Cislo verze je automaticky nastaveno dle nazvu build branche, napriklad `1.0` pro branch `build/1.0`
- Cislo buildu je automaticky generovano na CI, hodnota nastavena v Xcode je ignorovana
- Z aktualni develop branche je nutne vytvorit build branch prikazem `git checkout -b 'build/1.0'`
- Pro spusteni buildu staci pushnout vytvorenou build branch `git push origin build/1.0`
- Automaticky dojde k buildu alpha/beta/production verze a releasu alpha verze prostrednictvim TestFlight
- V pripade ze build branch obsahuje nejake dodatecne zmeny, je nutne vytvorit merge request do developu
