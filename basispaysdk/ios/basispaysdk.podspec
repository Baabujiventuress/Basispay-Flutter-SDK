#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint basispaysdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'basispaysdk'
  s.version          = '1.1.0'
  s.summary          = 'Payment gateway Flutter Plugin by Basispay team'
  s.description      = <<-DESC
Flutter SDK kit for payment gateway transactions within India
                       DESC
   s.homepage         = 'https://github.com/Baabujiventuress/Basispay-Flutter-SDK'
       s.license          = { :file => '../LICENSE' }
       s.author           = { 'Baabujiventuress' => 'basispay@gmail.com' }
       s.source           = { :path => '.' }

       s.source_files = 'Classes/**/*'
       s.dependency 'Flutter'
       s.platform = :ios, '11.0'
       s.preserve_paths = 'BasisPay.xcframework'
       s.xcconfig = { 'OTHER_LDFLAGS' => '-framework BasisPay' }
       s.vendored_frameworks = 'BasisPay.xcframework'

       # Flutter.framework does not contain a i386 slice.
       s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
       s.swift_version = '5.0'
       s.public_header_files = 'Classes/**/*.h'
  end