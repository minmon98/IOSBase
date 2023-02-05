# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

def shared_pods
  pod 'Alamofire', '~> 4.9'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'SDWebImage'
  pod 'IQKeyboardManager'
  pod 'Localize-Swift'
  pod 'SVProgressHUD'
end

target 'IOSBase' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for IOSBase
  shared_pods

end

target 'IOSBaseTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'IOSBaseUITests' do
  # Pods for testing
end
