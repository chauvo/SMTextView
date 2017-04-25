#
# Be sure to run `pod lib lint SMTextView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SMTextView'
  s.version          = '0.2.0'
  s.summary          = 'SMTextView provides an easy way to specify a placeholder using a text view. SMTextView is IBDesignable allowing it to be customized easily through interface builder.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SMTextView is a custom implementation of UITextView with a placeholder. This implementation contains the ability to customize top, left, bottom, and right insets individually. SMTextView is compatible with Interface Builder.

                       DESC

  s.homepage         = 'https://github.com/mandrusiaks/SMTextView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mandrusiaks' => 'mandrusiaks@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/mandrusiaks/SMTextView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SMTextView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SMTextView' => ['SMTextView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end