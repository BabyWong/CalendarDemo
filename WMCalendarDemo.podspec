
Pod::Spec.new do |hw|

hw.name             = 'WMCalendarDemo'
hw.version          = '0.0.2'
hw.license          = 'MIT'
hw.author       = { "Heaven" => "wenmeiwong@126.com" }
hw.homepage         = 'https://github.com/BabyWong/CalendarDemo.git'
hw.ios.deployment_target = "8.0"
hw.summary          = '集成项目需要的日历控件'
hw.source           = { :git => 'https://github.com/BabyWong/CalendarDemo.git', :tag => '0.0.2' }
hw.source_files     = 'CalendarView/**/*.{h,m}'
hw.requires_arc     = true



end
