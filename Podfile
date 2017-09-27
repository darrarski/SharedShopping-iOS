source 'git://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

target 'SharedShoppingApp' do
	pod 'Reveal-SDK', :configurations => ['Debug']
	pod 'SwiftLint', '~> 0.22'
	target 'SharedShoppingAppTests' do
		inherit! :search_paths
	end
end
