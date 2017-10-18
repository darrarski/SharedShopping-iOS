source 'git://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

target 'SharedShoppingApp' do
  pod 'Reveal-SDK', :configurations => ['Debug']
  pod 'SwiftLint', '~> 0.22'
  pod 'RxSwift', '~> 4.0'
  pod 'RxCocoa', '~> 4.0'
  pod 'SnapKit', '~> 4.0'
  target 'SharedShoppingAppTests' do
    inherit! :search_paths
    pod 'Quick', '~> 1.1'
    pod 'Nimble', '~> 7.0'
    pod 'RxTest', '~> 4.0'
    pod 'RxBlocking', '~> 4.0'
  end
end

post_install do |installer|

  print "Configuring Swift Optimization Level for pods\n"
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.name.include? 'Release'
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
      else
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
      end
    end
  end

end
