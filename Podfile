# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
pod 'Firebase/Analytics'
pod 'Firebase/Auth'
pod 'Firebase/Firestore'
pod "youtube-ios-player-helper", "~> 1.0.3"
pod 'FirebaseFirestoreSwift', '8.8.0-beta'
pod 'MessageKit'
pod 'Alamofire', '~> 5.4'

target 'ValU' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ValU

  target 'ValUTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ValUUITests' do
    # Pods for testing
  end
post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.5'
    end
  end
end
end
