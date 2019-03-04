# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

def shared_pods
    # App analytics
    pod 'Fabric'
    pod 'Crashlytics'
    
    # Functional reactive programming
    pod 'RxSwift'
    pod 'RxCocoa'
    
    # Networking + database
    pod 'Moya/RxSwift'
    pod 'AlamofireImage'
    pod 'RealmSwift'
    pod 'RxRealm'
    pod 'KeychainAccess'
      
    # Other utilities
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

    installer.pods_project.build_configurations.each do |config|
        # Prevent signing
        config.build_settings['PROVISIONING_PROFILE_SPECIFIER'] = ''
        config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
        config.build_settings['CODE_SIGNING_REQUIRED'] = 'NO'
    end

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
