Pod::Spec.new do |s|

s.name         = "WMCalendar"   # 仓库名字
s.version      = "0.0.2"
s.summary      = "CalendarDemo"
s.description  = "A short description of CalendarDemo. 简单的日历展示 选择器"
s.homepage     = "https://github.com/BabyWong/CalendarDemo.git"
s.license      = "MIT"
s.author       = "Heaven"
#  s.platform     = :ios, "8.0"
s.ios.deployment_target = "8.0"
s.source       = { :git => "https://github.com/BabyWong/CalendarDemo.git", :tag => "#{s.version}" }
s.source_files  = "CalendarView/**/*.{h,m}"
s.requires_arc = true

end
