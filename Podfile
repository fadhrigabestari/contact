# Uncomment the next line to define a global platform for your project
platform :ios, '12.1'

def contact_tests
  pod 'Quick'
  pod 'Nimble'
end

target 'Contact' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Contact
  pod 'Alamofire', '~> 4.7'

  target 'ContactTests' do
    contact_tests
    inherit! :search_paths
    # Pods for testing
  end
end
