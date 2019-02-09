# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

def shared_pods
    # Pods for app analytics
    pod 'Fabric'
    pod 'Crashlytics'
    
    # Pods for FRP
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxDataSources'
    
    # Pods for networking + data serialization
    pod 'Moya/RxSwift'
    pod 'AlamofireImage'
    pod 'RealmSwift'
    pod "RxRealm"
    pod 'KeychainAccess'
      
    # Pods for localization
    pod 'SwiftGen'
end

workspace 'DevStack'

target 'DevStack' do
    shared_pods
end

target 'DevStack_Alpha' do
    shared_pods
end

target 'DevStack_Beta' do
    shared_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|

            # Ignore documentation warnings
            config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'

            # Update the Swift version if necessary
            config.build_settings['SWIFT_VERSION'] = '4.2'

            # Turn on Whole Module Optimization
            if config.name == 'Release'
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
            else
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
            end
        end
    end
end
