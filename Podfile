# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

# Remove Pods related warnings
inhibit_all_warnings!

target 'JSONPhotos' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for JSONPhotos
  pod 'SwiftLint', '~> 0.46.2'

  # ReactiveX
  pod 'RxSwift', '~> 6.5.0'
  pod 'RxCocoa'
  pod 'RxDataSources'

  target 'JSONPhotosTests' do
    inherit! :search_paths
    # Pods for testing

    # ReactiveX
    pod 'RxTest'
    pod 'RxBlocking'
    
  end

  target 'JSONPhotosUITests' do
    # Pods for testing
  end

end
