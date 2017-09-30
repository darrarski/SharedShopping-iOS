source 'git://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

target 'SharedShoppingApp' do
  pod 'Reveal-SDK', :configurations => ['Debug']
  pod 'SwiftLint', '~> 0.22'
  pod 'RxSwift', '~> 3.6'
  pod 'RxCocoa', '~> 3.6'
  pod 'SnapKit', '~> 4.0'
  target 'SharedShoppingAppTests' do
    inherit! :search_paths
    pod 'Quick', '~> 1.1'
    pod 'Nimble', '~> 7.0'
    pod 'RxTest', '~> 3.6'
    pod 'RxBlocking', '~> 3.6'
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

  pods = ['RxSwift', 'RxCocoa', 'Quick', 'Nimble', 'RxTest', 'RxBlocking']
  installer.pods_project.targets.each do |target|
    if pods.include? target.name
      print "Setting Swift 3.2 for " + target.name + " pod\n"
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.2'
      end
    end
  end

end
