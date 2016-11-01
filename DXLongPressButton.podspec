#
# Be sure to run `pod lib lint DXLongPressButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DXLongPressButton'
  s.version          = '0.1.0'
  s.summary          = 'A subclass of UIButton that includes UILongPressEvent and IBInspectable long press duration'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A subclass of UIButton that includes UILongPressEvent and IBInspectable long press duration
                       DESC

  s.homepage         = 'https://github.com/s3lvin/DXLongPressButton'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'S3lvin' => 'mariaselvin@gmail.com' }
  s.source           = { :git => 'https://github.com/s3lvin/DXLongPressButton.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'DXLongPressButton/Classes/**/*'

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
