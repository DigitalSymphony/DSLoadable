#
# Be sure to run `pod lib lint DSLoadable.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DSLoadable'
  s.version          = '1.0.0'
  s.summary          = 'Let\'s embrace non-blocking loading views to build awesome apps!'
  s.swift_version    = '4.2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
To give the user a great user experience, we need to use non-blocking loaders for almost every element that does some asynchronous work. We tend to avoid handling this type of loading by blocking the whole view with a big loader. We don't want to manually add a loading view for each subview in the view controller, and managing them would be very hard. This repo provides fully customizable functions and methods which allows you to easily show loaders for any UIView. You can also plug in your favorite loading animation from another project!
                       DESC

  s.homepage         = 'https://github.com/DigitalSymphony/DSLoadable.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MaherKSantina' => 'maher.santina90@gmail.com' }
  s.source           = { :git => 'https://github.com/DigitalSymphony/DSLoadable.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DSLoadable/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DSLoadable' => ['DSLoadable/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'MSAutoView'
end
