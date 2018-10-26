
Pod::Spec.new do |spec|
spec.name             = 'WMCalendarDemo'
spec.version          = '0.0.2'
spec.license          = 'MIT'
spec.homepage         = 'https://github.com/BabyWong/CalendarDemo.git'
spec.authors          = { 'Heaven' => 'wenmeiwong@126.com' }
spec.summary          = '集成项目需要的日历控件'
spec.source           = { :git => 'https://github.com/BabyWong/CalendarDemo.git', :tag => "#{s.version}" }
spec.source_files     = 'CalendarView/**/*.{h,m}'
#spec.framework        = 'SystemConfiguration'
spec.requires_arc     = true
end
