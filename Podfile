# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

def shared_pods
    # App analytics
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'Firebase'
    
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

    # Flipper
    pod 'FlipperKit', :configurations => ['Debug']
    pod 'FlipperKit/FlipperKitLayoutComponentKitSupport', :configurations => ['Debug']
    pod 'FlipperKit/SKIOSNetworkPlugin', :configurations => ['Debug']
    pod 'FlipperKit/FlipperKitUserDefaultsPlugin', :configurations => ['Debug']
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

# This will cause Flipper and it's dependencies to be built as a static library
$static_framework = [
    'FlipperKit', 'Flipper', 'Flipper-Folly',
    'CocoaAsyncSocket', 'ComponentKit', 'DoubleConversion',
    'glog', 'Flipper-PeerTalk', 'Flipper-RSocket', 'Yoga', 'YogaKit',
    'CocoaLibEvent', 'OpenSSL-Universal', 'boost-for-react-native'
]

pre_install do |installer|
    Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
    installer.pod_targets.each do |pod|
        if $static_framework.include?(pod.name)
            def pod.build_type;
            Pod::Target::BuildType.static_library
            end
        end
    end
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
            config.build_settings['SWIFT_VERSION'] = '5.0'

            # Turn on Whole Module Optimization
            if config.name == 'Release'
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
            else
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
            end
        end
    end

    # This adds the -DFB_SONARKIT_ENABLED flag to OTHER_SWIFT_FLAGS, necessary to build Flipper swift target
    installer.pods_project.targets.each do |target|
      if target.name == 'YogaKit'
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = '4.1'
        end
      end
    end
    file_name = Dir.glob("*.xcodeproj")[0]
    app_project = Xcodeproj::Project.open(file_name)
    app_project.native_targets.each do |target|
        target.build_configurations.each do |config|
          if (config.build_settings['OTHER_SWIFT_FLAGS'])
            unless config.build_settings['OTHER_SWIFT_FLAGS'].include? '-DFB_SONARKIT_ENABLED'
              puts 'Adding -DFB_SONARKIT_ENABLED ...'
              swift_flags = config.build_settings['OTHER_SWIFT_FLAGS']
              if swift_flags.split.last != '-Xcc'
                config.build_settings['OTHER_SWIFT_FLAGS'] << ' -Xcc'
              end
              config.build_settings['OTHER_SWIFT_FLAGS'] << ' -DFB_SONARKIT_ENABLED'
            end
          else
            puts 'OTHER_SWIFT_FLAGS does not exist thus assigning it to `$(inherited) -Xcc -DFB_SONARKIT_ENABLED`'
            config.build_settings['OTHER_SWIFT_FLAGS'] = '$(inherited) -Xcc -DFB_SONARKIT_ENABLED'
          end
          app_project.save
        end
    end
    installer.pods_project.save

end
