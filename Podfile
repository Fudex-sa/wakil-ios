# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Superfan' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Speed

pod 'Alamofire', '~> 5.4'
pod 'Kingfisher', '= 6.3.1'
pod 'Firebase'
pod 'Firebase/Messaging'
pod 'Firebase/Crashlytics'
pod 'IQKeyboardManagerSwift'
pod 'R.swift'

pod 'Cosmos'
pod 'MBProgressHUD'
pod 'GooglePlaces', '= 3.0.3'
pod 'GoogleMaps', '= 3.0.3'
pod 'GooglePlacesSearchController'
pod 'SwiftyGif'
pod 'lottie-ios'
pod 'KDCircularProgress'
pod 'CameraManager', '~> 5.1'

pod 'FBSDKCoreKit', '~> 14.0'
pod 'FBSDKLoginKit', '~> 14.0'
pod 'FBSDKShareKit', '~> 14.0'
pod 'GoogleSignIn'
pod 'Cache'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
    # some older pods don't support some architectures, anything over iOS 11 resolves that
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end

