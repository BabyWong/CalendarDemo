
#  Be sure to run `pod spec lint WMCalendarView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
# s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
#  Licensing your code is important. See http://choosealicense.com for more info.

Pod::Spec.new do |s|

  s.name         = "WMCalendarView"
  s.version      = "0.0.1"
  s.summary      = "A short description of WMCalendarView. 简单的日历展示 选择器"
  s.homepage     = "https://github.com/BabyWong/CalendarDemo"
  s.license      = "MIT"
  s.author             = "Heaven"
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/BabyWong/CalendarDemo", :tag => "#{s.version}" }
  s.source_files  = "CalendarView", "CalendarView/**/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "Classes/**/*.h
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
