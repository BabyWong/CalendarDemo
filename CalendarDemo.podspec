Pod::Spec.new do |s|



  s.name         = "CalendarDemo"   # 仓库名字
  s.version      = "0.0.1"
  s.summary      = "CalendarDemo, 集成项目需要的日历控件"
  s.description  = "A short description of CalendarDemo. 简单的日历展示 选择器"
  s.homepage     = "https://github.com/BabyWong/CalendarDemo.git"
  s.license      = "MIT"
  s.author       = "Heaven"
#  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/BabyWong/CalendarDemo.git", :tag => "#{s.version}" }
  s.source_files  = "CalendarView/**/*.{h,m}"
  s.requires_arc = true
# s.dependency "JSONKit", "~> 1.4"

  #s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "Classes/**/*.h
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }


end
