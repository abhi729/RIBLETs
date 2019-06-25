platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings!

target 'RIBLETs' do
  pod 'RIBs', '~> 0.9'
  pod 'SnapKit'
  pod 'RxCocoa'
end

target 'RIBLETsTests' do
    pod 'RIBs', '~> 0.9'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['SnapKit'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
    end
  end
end
